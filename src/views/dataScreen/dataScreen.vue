<!--
 * @Description: 驾驶舱 页面
 * @Author: mhf
 * @Date: 2024/2/23 22:11
-->
<template>
  <div class="dataScreen">
    <baidu-map
      class="dataScreen-map"
      scroll-wheel-zoom
      :mapType="mapType"
      :center="mapCenter"
      :zoom="mapZoom"
    >
    </baidu-map>

    <div class="dataScreen-top">
      <topComp ref="topComp" />
    </div>
    <div class="dataScreen-left">
      <leftComp ref="leftComp" />
    </div>
    <div class="dataScreen-right">
      <rightComp ref="rightComp" />
    </div>
    <div class="dataScreen-bottom">
      <bottomComp ref="bottomComp" />
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import topComp from "@/views/dataScreen/topComp.vue";
import bottomComp from "@/views/dataScreen/bottomComp.vue";
import leftComp from "@/views/dataScreen/leftComp.vue";
import rightComp from "@/views/dataScreen/rightComp.vue";

@Component({
  components: { topComp, bottomComp, leftComp, rightComp },
})
export default class dataScreen extends Vue {
  mapCenter: any = {
    lng: 116.404,
    lat: 39.915,
  }; // 地图中心点
  mapZoom: number = 9; // 地图缩放层级
  mapType: string = "BMAP_HYBRID_MAP"; // 地图类型

  changeMapType(type: any) {
    this.mapType = type;
  }
}
</script>

<style lang="scss" scoped>
$margin: 20px; // 边距
$width: 100vw;
$boxWidth: 400px;
$height: 100vh;
$topHeight: 128px;
$bottomHeight: 250px;
$bottomBgHeight: 30px;
$boxHeight: calc(#{$height} - #{$topHeight} - #{$bottomHeight});

.dataScreen {
  width: $width;
  height: $height;

  &-map {
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0;
    left: 0;
  }

  &-top {
    width: $width;
    height: $topHeight;
    position: absolute;
    top: 0;
    z-index: 9 !important;
  }

  &-left {
    width: $boxWidth;
    position: absolute;
    top: calc(#{$topHeight} - #{$margin} * 2);
    left: $margin;
    height: $boxHeight;
  }

  &-right {
    width: $boxWidth;
    height: $boxHeight;
    position: absolute;
    top: calc(#{$topHeight} - #{$margin} * 2);
    right: $margin;
  }

  &-bottom {
    height: $bottomHeight;
    position: absolute;
    left: $margin;
    right: $margin;
    bottom: $margin;
  }
}

::v-deep .anchorBL {
  display: none !important;
}
</style>
