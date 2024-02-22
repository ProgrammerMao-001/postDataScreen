<!-- 疫苗信息 -->
<template>
  <div class="main-view">
    <div class="comment-manage">
      <div class="r-content-header">
        <div class="r-content-header-left">
          <i class="el-icon-s-claim"></i>
          <span class="font"> 疫苗信息 </span>
        </div>

        <div class="r-content-header-right">
          <el-button
            icon="el-icon-search"
            size="small"
            @click="isShowSearchForm"
          >
            {{ showSearchForm ? "隐藏" : "查询" }}
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
          <el-form-item size="small" label="医院名称:">
            <el-input v-model="searchForm.hname"></el-input>
          </el-form-item>

          <el-form-item size="small" label="所在地区:">
            <el-cascader
              v-model="searchForm.areaid"
              :options="areaList"
              :props="areaProps"
              placeholder=""
              @change=""
              clearable
              filterable
            >
            </el-cascader>
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
            :height="tableHeight"
            stripe
            border
            :data="tableData.slice((pageNo - 1) * pageSize, pageNo * pageSize)"
            style="width: 100%"
            class="r-content-table my-table-1"
          >
            <el-table-column type="index" label="序号" width="60">
              <template slot-scope="scope">
                <span>{{ (pageNo - 1) * pageSize + scope.$index + 1 }}</span>
              </template>
            </el-table-column>
            <el-table-column
              show-overflow-tooltip
              prop="hname"
              label="医院名称"
            />
            <el-table-column
              show-overflow-tooltip
              prop="areaid"
              label="所在地区"
            >
              <template slot-scope="scope">
                <span> {{ getStringArea(scope.row.areaid) }} </span>
              </template>
            </el-table-column>
            <el-table-column
              show-overflow-tooltip
              prop="firstnum"
              label="第一针疫苗数"
            />
            <el-table-column
              show-overflow-tooltip
              prop="secondnum"
              label="第二针疫苗数"
            />
            <el-table-column
              show-overflow-tooltip
              prop="thirdnum"
              label="第三针疫苗数"
            />

            <el-table-column
              v-if="userInfo.role === '管理员'"
              prop=""
              label="操作"
              v-permission
            >
              <template slot-scope="scope">
                <el-button
                  type="text"
                  @click="showPublicDialog('编辑', scope.row)"
                  size="small"
                >
                  编辑
                </el-button>
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
    <publicDialog ref="publicDialog" />
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import { getHospitalListByHName } from "@/api/hospitalModule";
import { getAreaList } from "@/api/areaModule";
import publicDialog from "@/views/vaccineInformation/publicDialog.vue";
import { arrayToTree } from "@/utils/arrayToTree";

@Component({
  components: { publicDialog },
})
export default class RoleManage extends Vue {
  tableData: any = [];
  pageNo: any = 1;
  pageSize: any = 10;
  total: any = 0;
  tableHeight: Number = 650;
  searchForm: any = {
    hname: "",
    areaid: "",
  };
  areaList: any = [];
  areaProps: any = {
    label: "city",
    value: "id",
  };
  showSearchForm: boolean = false;
  userInfo: Object = {};

  // 获取全部的角色列表
  getHospitalList() {
    getHospitalListByHName({
      hname: this.searchForm.hname,
      areaid: this.searchForm.areaid,
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
    getHospitalListByHName({
      hname: this.searchForm.hname,
      areaid: this.searchForm.areaid[1],
    }).then((res: any) => {
      if (res.status === 200) {
        this.tableData = res.data.data;
        this.total = this.tableData.length;
      }
    });
  }

  // 重置
  handleRest() {
    this.$set(this.searchForm, "hname", "");
    this.$set(this.searchForm, "areaid", "");
    this.getHospitalList();
    this.pageNo = 1;
    this.pageSize = 10;
  }

  isShowSearchForm() {
    this.showSearchForm = !this.showSearchForm;
    if (this.showSearchForm) {
      this.tableHeight = 600;
    } else {
      this.tableHeight = 650;
    }
  }
  /**
   * 编辑的弹窗
   * */
  showPublicDialog(type: any, data: any) {
    let passData = {
      type,
      data,
    };
    (this.$refs.publicDialog as any).showDialog(passData);
  }

  /**
   * 获取区域列表
   * */
  getAreaList() {
    getAreaList({}).then((res: any) => {
      if (res.data.status === 200) {
        this.areaList = arrayToTree(res.data.data);
      }
    });
  }

  /**
   * 转换数据
   * */
  get getStringArea(): any {
    let res = "";
    return (area: any): any => {
      if (area) {
        this.areaList.forEach((item: any, index: any) => {
          item.children.forEach((areaIn: any, areaIndex: any) => {
            if (areaIn.id === area) {
              res = item.city + "/" + areaIn.city;
            }
          });
        });
      }
      return res;
    };
  }

  created() {
    this.getAreaList();
    this.getHospitalList();
    this.userInfo = JSON.parse(localStorage.getItem("userInfo") as any);
  }
}
</script>

<style lang="scss" scoped>
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
      color: #2244ff;

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
</style>
