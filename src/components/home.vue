<template>
  <div class="home">
    <el-container style="height: 100%">
      <el-header class="home-header">
        <topBar />
      </el-header>
      <el-container style="background-color: #eef4fd">
        <el-aside
          class="aside-class"
          :style="{
            width: !isOpenFlag ? '220px !important' : '84px !important',
          }"
        >
          <!-- 展开折叠时侧边栏的动态样式 -->
          <div
            :class="[
              isOpenFlag ? 'aside-box-shadow-close' : 'aside-box-shadow',
            ]"
          >
            <div class="aside-font">
              <div v-show="!isOpenFlag" class="aside-font-border"></div>
              <span v-show="!isOpenFlag"> 疫&nbsp;情&nbsp;防&nbsp;控 </span>
              <i
                style="cursor: pointer"
                @click="isOpen"
                class="el-icon-s-fold"
              ></i>
            </div>
            <sideBarComp style="margin-top: 6px" ref="sideBarComp" />
          </div>
        </el-aside>
        <el-container>
          <el-main style="width: 100%; height: 100%; background-color: #eef4fd">
            <div style="height: 100%">
              <div class="history-page-style">
                <!-- ▼ 历史记录选项卡 -->
                <history-page></history-page>
                <!-- ▼ 历史记录选项卡 -->
              </div>

              <keep-alive>
                <div style="height: calc(100% - 50px) !important">
                  <router-view></router-view>
                </div>
              </keep-alive>
            </div>
          </el-main>
        </el-container>
      </el-container>
    </el-container>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import sideBarComp from "@/components/sideBarComp.vue";
import topBar from "@/components/topBar.vue";
import bottomBar from "@/components/bottomBar.vue";
import historyPage from "@/components/historyPage.vue";

@Component({
  components: { sideBarComp, topBar, bottomBar, historyPage },
})
export default class Home extends Vue {
  isOpenFlag: any = false;

  isOpen() {
    (this.$refs.sideBarComp as any).changeIsCollapse();
    this.isOpenFlag = !this.isOpenFlag;
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/styles/colorMap";
.home-header {
  background: $greenOBg;
  height: 50px !important;
}

.aside-font-border {
  width: 6px;
  height: 22px;
  margin-top: 4px;
  background-color: $greenBg;
  border-radius: 20px;
}
</style>
