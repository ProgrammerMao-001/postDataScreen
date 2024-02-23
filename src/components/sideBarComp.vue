<!-- @desc 侧边栏sideBar的使用 -->
<template>
  <div>
    <el-menu
      class="el-menu"
      background-color="#ffffff"
      text-color="#606266"
      :unique-opened="true"
      :default-active="$route.path"
      :collapse="isCollapse"
      router
    >
      <sideBar :menuList="menuList" :isCollapse="isCollapse" />
    </el-menu>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from "vue-property-decorator";
import sideBar from "@/components/sideBar.vue";
import { getList } from "@/api/routerModule";
import { arrayToTree } from "@/utils/arrayToTree";

@Component({
  components: { sideBar },
})
export default class SideBarComp extends Vue {
  private menuList: any = [];
  isCollapse: any = false;
  role: string = "用户"; // 默认为用户登录
  /**
   * 控制是否折叠侧边栏
   */
  changeIsCollapse() {
    this.isCollapse = !this.isCollapse;
  }

  /**
   * 获取路由列表
   */
  getList() {
    getList()
      .then((res: any) => {
        if (res.status === 200 && res.data.status === 200) {
          // 遍历渲染侧边栏
          this.menuList = arrayToTree(res.data.data);
          // 保证 首页 菜单出现在第一个
          this.menuList.forEach((item: any, index: number) => {
            if (item.name === "首页") {
              this.menuList.splice(index, 1);
              this.menuList.unshift(item);
            }
            /* 过滤 用户和管理员的菜单分开渲染 */
            this.menuList = this.menuList.filter((item: any) => {
              return item.type.indexOf(this.role) !== -1;
            });
          });
        }
      })
      .catch((error: any) => {
        throw error;
      });
  }

  created() {
    this.role = JSON.parse((localStorage as any).getItem("userInfo")).role;
    this.getList();
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/styles/colorMap";
// todo 侧边栏的样式设置
.el-menu {
  border-right: none;
}

/deep/ .el-menu .el-menu-item:hover {
  outline: 0 !important;
  background-color: rgba(0, 180, 179, 0.2) !important;
  /*background: linear-gradient(270deg, #ffe3eb 0%, #FFB6C1 80%) !important;*/
}

/deep/ .el-menu .el-menu-item.is-active {
  color: $greenBg !important;
  /*background: linear-gradient(270deg, #ffe3eb 0%, #FFB6C1 80%) !important;*/
}

/deep/ .el-submenu__title:hover {
  background-color: rgba(0, 180, 179, 0.2) !important;
  /*background: linear-gradient(270deg, #ffe3eb 0%, #FFB6C1 80%) !important;*/
}

::v-deep .el-menu--collapse {
  width: 64px;
  overflow: hidden;
}
</style>
