<template>
  <div class="boxContent">
    <div class="boxContent-public-title">
      公司分布情况
    </div>
    <div class="boxContent-public-main">
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import {getCompanyListByPrams} from "@/api/companyModule";

@Component({
  components: {},
})
export default class bottomComp extends Vue {
  companyList: any = [] // 公司列表

  getCompanyList() {
    getCompanyListByPrams({}).then((res: any) => {
      this.companyList = res.data.data;
    });
  }
  mounted() {
    this.getCompanyList();
  }
}
</script>

<style lang="scss" scoped>
@import "publicStyle";

.boxContent-public-title {
  background: url("/public/img/dataScreen/bottomTitle.png");
  background-repeat: no-repeat;
  background-size: 100% 100%;
}

.boxContent-public-main {

}
</style>
