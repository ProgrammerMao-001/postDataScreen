<!--
 * @Description: 角色 页面
 * @Author: mhf
 * @Date: 2024/2/23 23:18
-->
<template>
  <div class="main-view">
    <div class="comment-manage">
      <div class="r-content-header">
        <div class="r-content-header-left">
          <i class="el-icon-takeaway-box"></i>
          <span class="font"> 角色管理 </span>
        </div>
      </div>

      <div>
        <el-form
          :inline="true"
          :model="searchForm"
          class=""
          style="margin: 20px 0 0 20px"
        >
          <el-form-item size="small" label="角色:">
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
            class="r-content-table my-table-1"
          >
            <el-table-column type="index" label="序号" width="60">
              <template slot-scope="scope">
                <span>{{ (pageNo - 1) * pageSize + scope.$index + 1 }}</span>
              </template>
            </el-table-column>
            <el-table-column show-overflow-tooltip prop="name" label="角色" />
            <el-table-column show-overflow-tooltip prop="id" label="id" />
            <el-table-column show-overflow-tooltip prop="pid" label="pid" />
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
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import { getRoleListByName } from "@/api/roleModule";

@Component({
  components: {},
})
export default class RoleManage extends Vue {
  tableData: any = [];
  pageNo: any = 1;
  pageSize: any = 10;
  total: any = 0;
  searchForm: any = {
    name: "",
  };

  // 获取全部的角色列表
  getCommentList() {
    getRoleListByName({
      name: this.searchForm.name,
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
    getRoleListByName({
      name: this.searchForm.name,
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
    this.getCommentList();
    this.pageNo = 1;
    this.pageSize = 10;
  }

  created() {
    this.getCommentList();
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/styles/colorMap";
.comment-manage {
  &-header {
    margin-left: 32px;
  }
}

.el-icon-delete {
  color: #f90;
}

.el-icon-delete:hover {
  cursor: pointer;
  font-size: 16px;
}

.r-content-header {
  height: 40px;
  border-bottom: 1px solid #eee;
  margin: 0px 18px 0;
  display: flex;
  justify-content: space-between;

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
</style>
