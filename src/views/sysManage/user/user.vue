<!--
 * @Description: 用户 页面
 * @Author: mhf
 * @Date: 2024/2/23 23:18
-->
<template>
  <div
    :class="[closeFlag ? 'public-style-have-lr' : 'public-style-have-lr-copy']"
  >
    <div v-if="showPublicPage" class="public-style-have-lr-left">
      <treeComp ref="treeComp" @on-response="getData" />
    </div>
    <div v-if="showPublicPage" class="center-box" @click="isClose">
      <i
        :class="[closeFlag ? 'el-icon-caret-left' : 'el-icon-caret-right']"
      ></i>
    </div>
    <div v-if="showPublicPage" class="public-style-have-lr-right">
      <div class="r-content">
        <!-- 标题栏 -->
        <div class="r-content-header">
          <div class="r-content-header-left">
            <i class="el-icon-user"></i>
            <span class="font"> 用户管理 </span>
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
              @click="showPublicPageMethod(null, '新增用户')"
            >
              新增
            </el-button>
          </div>
        </div>

        <!-- 搜索框 -->
        <div class="r-content-search-box" v-show="showSearchForm">
          <el-form :inline="true" :model="formData" label-width="70px">
            <el-form-item label="用户名:" size="small">
              <el-input
                v-model="formData.username"
                placeholder="请输入用户名"
              ></el-input>
            </el-form-item>

            <el-form-item size="small">
              <el-button-group>
                <el-button type="primary" @click="onSearchForm">搜索</el-button>
                <el-button type="" @click="onRestForm"> 重置</el-button>
              </el-button-group>
            </el-form-item>
          </el-form>
        </div>

        <!-- 表格 -->
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
            <el-table-column prop="username" label="用户名" />
            <el-table-column prop="role" label="账号类型" />
            <el-table-column prop="id" label="id" />
            <el-table-column label="操作" width="100">
              <template slot-scope="scope">
                <i
                  class="el-icon-info"
                  @click="showPublicPageMethod(scope.row, '用户详情')"
                  title="用户详情"
                ></i>
                <i
                  class="el-icon-edit"
                  @click="showPublicPageMethod(scope.row, '编辑用户')"
                  title="编辑用户"
                ></i>
                <i
                  class="el-icon-delete"
                  @click="deleteUser(scope.row)"
                  title="删除用户"
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
    <userPage v-else :willPassData="willPassData" />
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import { deleteUser, updateUser, getUserByUserName } from "@/api/userModule";
import treeComp from "@/components/treeComp.vue";
import userPage from "@/views/sysManage/user/userPage.vue";
@Component({
  components: { treeComp, userPage },
})
export default class TsComp extends Vue {
  closeFlag: boolean = true;
  showSearchForm: boolean = false;
  formData: any = {
    username: "", // 用户名
    role: "", // 账号类型
  };
  tableData: any = [];
  pageNo: number = 1;
  pageSize: number = 10;
  total: number = 0;
  showPublicPage: any = true; // 展示子页的标记
  willPassData: any = {}; // 传给publicPage的数据

  /**
   * @Event 显示/隐藏左侧
   * @description:
   * @author: mhf
   * @time: 2024-02-23 23:23:27
   **/
  isClose() {
    this.closeFlag = !this.closeFlag;
  }

  /**
   * @Event 查询
   * @description:
   * @author: mhf
   * @time: 2024-02-23 23:23:21
   **/
  onSearchForm() {
    this.getTableData();
  }

  /**
   * @Event 重置
   * @description:
   * @author: mhf
   * @time: 2024-02-23 23:23:16
   **/
  onRestForm() {
    this.formData = {
      username: "", // 用户名
      role: "", // 账号类型
    };
    this.pageNo = 1;
    this.pageSize = 10;
    (this.$refs.treeComp as any).clearCheck();
    this.getTableData();
  }

  /**
   * @Event 获取表格数据
   * @description:
   * @author: mhf
   * @time: 2024-02-23 23:23:11
   **/
  getTableData() {
    this.pageNo = 1;
    this.pageSize = 10;
    getUserByUserName(this.formData)
      .then((res: any) => {
        if (res.data.status === 200) {
          this.tableData = res.data.data;
        }
      })
      .catch((e: any) => {
        this.$message.error("获取表格数据失败，请稍后再试！");
      });
  }

  /**
   * @Event 分页切换事件
   * @description:
   * @author: mhf
   * @time: 2024-02-23 23:23:02
   **/
  handleSizeChange(val: any) {
    this.pageNo = 1;
    this.pageSize = val;
  }

  /**
   * @Event 分页切换事件
   * @description:
   * @author: mhf
   * @time: 2024-02-23 23:22:47
   **/
  handleCurrentChange(val: any) {
    this.pageNo = val;
  }

  /**
   * @Event 表格 编辑、新增用户
   * @description:
   * @author: mhf
   * @time: 2024-02-23 23:22:42
   **/
  showPublicPageMethod(data: any, type: string) {
    this.showPublicPage = !this.showPublicPage;
    this.willPassData = {
      data,
      type,
    };
  }

  /**
   * @Event 返回当前页面
   * @description:
   * @author: mhf
   * @time: 2024-02-23 23:22:34
   **/
  backIndex() {
    this.showPublicPage = true;
  }

  /**
   * @Event 表格 删除用户
   * @description:
   * @author: mhf
   * @time: 2024-02-23 23:22:27
   **/
  deleteUser(data: any) {
    this.$confirm("此操作将永久删除该条数据, 是否继续?", "提示", {
      confirmButtonText: "确定",
      cancelButtonText: "取消",
      type: "warning",
    })
      .then(() => {
        deleteUser({
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

  /**
   * @Event 获取父组件（树）勾选上的值
   * @description:
   * @author: mhf
   * @time: 2024-02-23 23:22:13
   **/
  getData(data: any) {
    this.formData.role = data.toString();
    this.getTableData();
  }

  created() {
    this.getTableData();
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

.l-content {
  &-header {
    border-bottom: 1px solid #eee;
    height: 30px;
    display: flex;
    justify-content: space-between;
    margin: 20px 16px 0;

    &-left {
      font-size: 15px;
      margin-left: 4px;
      font-weight: 600;
      color: #666;

      .el-icon-menu {
        color: #2244ff;
      }
    }

    &-right {
      width: 42px;
      font-size: 14px;
      color: #666;

      .el-icon-arrow-down,
      .el-icon-arrow-up {
        margin-right: 6px;
      }

      .el-icon-refresh,
      .el-icon-arrow-down,
      .el-icon-arrow-up {
        cursor: pointer;
      }
    }
  }

  &-center {
    margin: 10px 0 0 12px;
    display: flex;
    font-size: 14px;
    color: #666;
  }

  &-main {
    padding: 10px;

    &-tree {
      font-size: 14px;
      color: #666;
    }
  }
}

.el-icon-edit {
  color: #108c53;
  margin-right: 12px;
  cursor: pointer;
}

.el-icon-info {
  color: #409eff;
  margin-right: 12px;
  cursor: pointer;
}

.el-icon-delete {
  color: #dd5a43;
  cursor: pointer;
}

::v-deep .el-pagination.is-background .el-pager li:not(.disabled).active {
  background-color: #2244ff;
}

::v-deep .el-radio-group {
  display: flex;
  margin-top: 3px;

  .el-radio {
    margin-right: 10px !important;
  }
}

.table {
  flex: 1;
}
</style>
