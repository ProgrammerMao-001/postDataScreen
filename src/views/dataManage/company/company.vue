<!--
 * @Description: 公司 页面
 * @Author: mhf
 * @Date: 2024/2/24 0:10
-->
<template>
  <div class="main-view">
    <div v-if="showPage === 1" class="comment-manage">
      <div class="r-content-header">
        <div class="r-content-header-left">
          <i class="el-icon-office-building"></i>
          <span class="font"> 公司 </span>
        </div>

        <div class="r-content-header-right">
          <el-button
            icon="el-icon-search"
            size="small"
            @click="showSearchForm = !showSearchForm"
          >
            {{ showSearchForm ? "隐藏" : "查询" }}
          </el-button>
          <el-button
            icon="el-icon-plus"
            type="primary"
            size="small"
            @click="showPublicPage('新增', null)"
          >
            新增
          </el-button>
        </div>
      </div>

      <!-- 搜索框 -->
      <div class="r-content-search-box" v-show="showSearchForm">
        <el-form
          :inline="true"
          :model="searchForm"
          class=""
          style="margin: 20px 0 0 20px"
        >
          <el-form-item size="small" label="企业名称:">
            <el-input v-model="searchForm.name"></el-input>
          </el-form-item>

          <el-form-item size="small" label="经营状态:">
            <el-select v-model="searchForm.business_status" placeholder="">
              <el-option
                v-for="item in businessStatusList"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              >
              </el-option>
            </el-select>
          </el-form-item>

          <el-form-item size="small">
            <el-button type="primary" @click="handleSearch">查询</el-button>
            <el-button type="" @click="handleRest">重置</el-button>
          </el-form-item>
        </el-form>
      </div>

      <!-- 表格 -->
      <div style="width: 97%; margin: 0 auto">
        <div class="table">
          <el-table
            stripe
            border
            :data="tableData.slice((pageNo - 1) * pageSize, pageNo * pageSize)"
            style="width: 100%"
          >
            <el-table-column type="index" label="序号" width="60">
              <template slot-scope="scope">
                <span>{{ (pageNo - 1) * pageSize + scope.$index + 1 }}</span>
              </template>
            </el-table-column>
            <el-table-column
              show-overflow-tooltip
              prop="name"
              label="企业名称"
            />
            <el-table-column
              show-overflow-tooltip
              prop="user_name"
              label="法定代表人"
            />
            <el-table-column
              show-overflow-tooltip
              prop="founded"
              label="成立时间"
            />
            <el-table-column
              show-overflow-tooltip
              prop="address"
              label="注册地址"
            />
            <el-table-column
              show-overflow-tooltip
              prop="social_code"
              label="统一社会信用代码"
            />
            <el-table-column prop="" label="操作" min-width="120">
              <template slot-scope="scope">
                <i
                  class="el-icon-info"
                  @click="showPublicPage('详情', scope.row)"
                  title="公司详情"
                ></i>
                <i
                  class="el-icon-edit"
                  @click="showPublicPage('编辑', scope.row)"
                  title="编辑公司"
                ></i>
                <i
                  class="el-icon-delete"
                  @click="deleteRow(scope.row)"
                  title="删除公司"
                ></i>
              </template>
            </el-table-column>
          </el-table>
        </div>

        <!-- 分页 -->
        <div>
          <el-pagination
            background
            style="text-align: right; margin-top: 15px"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="pageNo"
            :page-sizes="[5, 10, 20, 30, 50]"
            :page-size="pageSize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="tableData.length"
          >
          </el-pagination>
        </div>
      </div>
    </div>
    <companyPage
      v-if="showPage === 2"
      ref="companyPage"
      :willPassData="willPassData"
    />
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import { deleteCompany, getCompanyListByPrams } from "@/api/companyModule";
import companyPage from "@/views/dataManage/company/companyPage.vue";

@Component({
  components: { companyPage },
})
export default class RoleManage extends Vue {
  tableData: any = [];
  pageNo: any = 1;
  pageSize: any = 10;
  total: any = 0;
  searchForm: any = {
    name: "",
    business_status: "",
  };
  showSearchForm: boolean = false;
  showPage: number = 1;
  willPassData: any = {};
  businessStatusList: any = []; // 经营状态列表

  // 获取公司数据
  getTableData() {
    let userInfo = JSON.parse((localStorage as any).getItem("userInfo"));
    getCompanyListByPrams({
      user_id: userInfo.roleid == 2 ? userInfo.id : null, // 1:管理员 2:普通用户
      name: this.searchForm.name,
      business_status: this.searchForm.business_status,
    }).then((res: any) => {
      if (res.status === 200) {
        this.tableData = res.data.data;
        this.total = this.tableData.length;
      }
    });
  }

  /**
   * @desc 分页切换事件
   */
  handleSizeChange(val: any) {
    this.pageNo = 1;
    this.pageSize = val;
  }

  // 分页切换事件
  handleCurrentChange(val: any) {
    this.pageNo = val;
  }

  // 搜索
  handleSearch() {
    this.getTableData();
  }

  // 重置
  handleRest() {
    this.$set(this.searchForm, "name", "");
    this.$set(this.searchForm, "business_status", "");
    this.getTableData();
    this.pageNo = 1;
    this.pageSize = 10;
  }

  /**
   * @Event 新增，编辑，详情的公共弹窗
   * @description:
   * @author: mhf
   * @time: 2024-02-24 15:13:40
   **/
  showPublicPage(type: any, data: any) {
    this.showPage = 2;
    this.willPassData = { type, data };
  }

  backIndex() {
    this.showPage = 1;
    this.getTableData();
  }

  deleteRow(data: any) {
    this.$confirm("此操作将永久删除该条数据, 是否继续?", "提示", {
      confirmButtonText: "确定",
      cancelButtonText: "取消",
      type: "warning",
    })
      .then(() => {
        deleteCompany({
          id: data.id,
        })
          .then((res: any) => {
            if (res.data.status === 200) {
              this.$message.success("删除成功！");
            } else {
              this.$message.error("删除失败，请稍后再试！");
            }
            this.getTableData();
          })
          .catch((e: any) => {
            console.log(e);
          });
      })
      .catch(() => {
        this.$message({
          type: "info",
          message: "已取消删除",
        });
      });
  }
  getBusinessStatusList() {
    (this as any).getDict("businessStatus").then((res: any) => {
      let arr = res.data.data[0]?.data || "[]";
      this.businessStatusList = JSON.parse(arr);
    });
  }
  created() {
    this.getTableData();
    this.getBusinessStatusList();
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/styles/colorMap";

.r-content {
  margin: 10px;
  height: calc(100% - 20px);
  display: flex;
  flex-direction: column;

  &-header {
    height: 40px;
    border-bottom: 1px solid #eee;
    margin: 0px 18px 0;
    display: flex;
    justify-content: space-between;
    padding-top: 10px;

    &-left {
      color: $greenBg;

      .font {
        font-size: 15px;
        font-weight: 600;
        color: #666;
        line-height: 40px;
      }
    }

    &-right {
    }
  }

  &-search-box {
    margin: 10px 10px -10px;
  }

  &-table {
    height: 99%;
    width: 98% !important;
    margin: 10px auto;
  }
}

.table {
  margin-top: 20px;
}
</style>
