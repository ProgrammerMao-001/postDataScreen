<template>
  <div class="boxContent">
    <div class="boxContent-public">
      <div class="boxContent-public-title">职位分布情况</div>
      <div class="boxContent-public-main"></div>
    </div>

    <div class="boxContent-public">
      <div class="boxContent-public-title">职位薪资情况</div>
      <div class="boxContent-public-main"></div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";

@Component({
  components: {},
})
export default class leftComp extends Vue {}
</script>

<style lang="scss" scoped>
@import "publicStyle";
</style>
