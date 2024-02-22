<!-- @desc 项目的头部文件 -->
<template>
  <div class="top-bar">
    <div class="top-bar-logo">
      <img src="../assets/pic/logo.png" alt="" />
    </div>

    <div class="login-info">
      <div class="login-info-img">
        <el-image
          style="width: 40px; height: 40px; border-radius: 50%"
          :src="headImg"
          :preview-src-list="[headImg]"
        >
        </el-image>
      </div>
      <div class="login-info-dropdown">
        <el-dropdown @command="handleCommand">
          <span class="el-dropdown-link">
            {{ userName }} <i class="el-icon-arrow-down el-icon--right"></i>
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item
              v-if="role === '用户'"
              command="personalCenter"
              icon="el-icon-switch-button"
              >个人中心</el-dropdown-item
            >
            <el-dropdown-item command="logOut" icon="el-icon-switch-button"
              >退出登陆</el-dropdown-item
            >
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import getDay from "@/utils/getDay";

@Component({
  components: {},
})
export default class TopBar extends Vue {
  headImg: any = ""; // 头像
  userName: string = "admin";
  togetherDay: any = 0;
  role: string = ""; // 角色类型

  handleCommand(command: any) {
    console.log(command);
    switch (command) {
      case "personalCenter":
        this.$router.push("/personalCenter");
        break;
      case "logOut":
        this.$confirm("确定退出登陆吗?", "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning",
        })
          .then(() => {
            this.$store.dispatch("resetTabsView"); // 重置tabsView
            localStorage.clear();
            this.$router.push("/login");
            this.$message({
              type: "success",
              message: "退出成功!",
            });
          })
          .catch(() => {
            this.$message({
              type: "info",
              message: "已取消",
            });
          });
        break;
    }
  }

  created() {
    this.togetherDay = getDay("2022-03-30 00:00:00");
    let userInfo = JSON.parse((localStorage as any).getItem("userInfo"));
    this.userName = userInfo.username;
    this.headImg = userInfo.headimg;
    this.role = userInfo.role;
  }
}
</script>

<style lang="scss" scoped>
.top-bar {
  position: relative;

  &-logo {
    position: absolute;
    left: -10px;
    top: 2px;
    width: 480px;

    img {
      width: 100%;
    }
  }

  .time-weather-box {
    width: 300px;
    height: 50px;
    position: absolute;
    float: right;
    right: 130px;
    color: #fff;
    letter-spacing: 4px;
    font-size: 12px;
  }

  .login-info {
    position: absolute;
    right: 30px;
    top: 0;
    display: flex;

    &-img {
      margin: 6px 10px 0 0;
    }

    &-dropdown {
      line-height: 50px;
      cursor: pointer;
    }
  }
}

.el-dropdown {
  color: #fff !important;
  letter-spacing: 2px;
}
</style>
