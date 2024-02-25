<template>
  <div class="boxContent">
    <div class="boxContent-public-title">
      职位分布情况
    </div>
    <div class="boxContent-public-main"></div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";

@Component({
  components: {},
})
export default class bottomComp extends Vue {}
</script>

<style lang="scss" scoped>
@import "publicStyle";

.boxContent-public-title {
  background: url("/public/img/dataScreen/bottomTitle.png");
  background-repeat: no-repeat;
  background-size: 100% 100%;
}
</style>
