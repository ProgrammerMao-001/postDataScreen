<!-- todo 面包屑 -->
<template>
  <div class="bottom-bar">
    <el-breadcrumb separator-class="el-icon-caret-right">
      <el-breadcrumb-item v-for="(item, index) in breadcrumbList" :key="index">
        <!-- <el-breadcrumb-item v-for="(item, index) in breadcrumbList" :to="{ path: item.path }"> -->
        {{ item.title }}
      </el-breadcrumb-item>
    </el-breadcrumb>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";

@Component({
  components: {},
})
export default class BottomBar extends Vue {
  private breadcrumbList: any = [];

  @Watch("$route")
  routerChange(newData: any, oldData: any) {
    this.breadcrumbList = [];
    this.publicFunction(newData);
  }

  /**
   * 提取出来的公共的方法
   * 如果列表里的两项都相同则取一项即可
   * */
  publicFunction(data: any) {
    data.matched.forEach((item: any, index: any) => {
      this.breadcrumbList.push({
        title: item.meta.title,
        path: item.path,
      });
    });
    for (let i = 0; i < this.breadcrumbList.length; i++) {
      for (let j = i + 1; j <= this.breadcrumbList.length; j++) {
        if (this.breadcrumbList[i] && this.breadcrumbList[j]) {
          if (this.breadcrumbList[i].title === this.breadcrumbList[j].title) {
            let arr = [];
            arr.push(this.breadcrumbList[j]);
            this.breadcrumbList = arr;
          }
        }
      }
    }
  }

  created() {
    this.publicFunction(this.$route);
  }
}
</script>

<style lang="scss" scoped>
::v-deep .el-icon-caret-right {
  color: red !important;
}
</style>
