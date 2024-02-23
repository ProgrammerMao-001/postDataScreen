<!--
 * @Description: 字典 页面
 * @Author: mhf
 * @Date: 2024/2/23 23:16
-->
<template>
  <div class="main-view">
    <div class="comment-manage">
      <div class="r-content-header">
        <div class="r-content-header-left">
          <i class="el-icon-collection"></i>
          <span class="font"> 字典 </span>
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
              @click="showPublicDialog('新增', null)"
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
          <el-form-item size="small" label="字典名:">
            <el-input v-model="searchForm.name"></el-input>
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
            <el-table-column show-overflow-tooltip prop="name" label="字典名" />
            <el-table-column show-overflow-tooltip prop="namephone" label="备注"/>
            <el-table-column prop="" label="操作" min-width="120">
              <template slot-scope="scope">
                <el-button
                    type="text"
                    @click="showPublicDialog('详情', scope.row)"
                    size="small"
                >
                  详情</el-button
                >
                <el-button
                    type="text"
                    @click="showPublicDialog('编辑', scope.row)"
                    size="small"
                >
                  编辑</el-button
                >
                <el-button
                    type="text"
                    @click="deletePeople(scope.row)"
                    size="small"
                >
                  删除</el-button
                >
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
    <dictDialog ref="dictDialog" />
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import { deleteDefinite, getDefiniteListByName } from "@/api/definiteModule";
import dictDialog from "@/views/sysManage/dict/dictDialog.vue";

@Component({
  components: { dictDialog },
})
export default class RoleManage extends Vue {
  tableData: any = [];
  pageNo: any = 1;
  pageSize: any = 10;
  total: any = 0;
  searchForm: any = {
    name: "",
    staticname: "",
  };
  showSearchForm: boolean = false;

  // 获取全部的角色列表
  getCommentList() {
    getDefiniteListByName({
      name: this.searchForm.name,
      staticname: this.searchForm.staticname,
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

  /**
   * @desc 分页切换事件
   */
  handleCurrentChange(val: any) {
    this.pageNo = val;
  }

  // 搜索
  handleSearch() {
    console.log(this.searchForm);
    getDefiniteListByName({
      name: this.searchForm.name,
      staticname: this.searchForm.staticname,
    }).then((res: any) => {
      if (res.status === 200) {
        this.tableData = res.data.data;
        this.total = this.tableData.length;
      }
    });
  }

  // 重置
  handleRest() {
    this.$set(this.searchForm, "name", "");
    this.$set(this.searchForm, "staticname", "");
    this.getCommentList();
    this.pageNo = 1;
    this.pageSize = 10;
  }

  /**
   * 新增，编辑，详情的公共弹窗
   * */
  showPublicDialog(type: any, data: any) {
    let passData = {
      type,
      data,
    };
    (this.$refs.dictDialog as any).showDialog(passData);
  }

  deletePeople(data: any) {
    this.$confirm("此操作将永久删除该条数据, 是否继续?", "提示", {
      confirmButtonText: "确定",
      cancelButtonText: "取消",
      type: "warning",
    })
        .then(() => {
          deleteDefinite({
            id: data.id,
          })
              .then((res: any) => {
                if (res.data.status === 200) {
                  this.$message.success("删除成功！");
                } else {
                  this.$message.error("删除失败，请稍后再试！");
                }
                this.getCommentList();
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

  created() {
    this.getCommentList();
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
