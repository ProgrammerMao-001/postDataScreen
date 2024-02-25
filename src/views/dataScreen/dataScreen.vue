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
      :center="mapCenter"
      :zoom="mapZoom"
    >
      <bm-map-type
        :map-types="['BMAP_NORMAL_MAP', 'BMAP_HYBRID_MAP']"
        :offset="mapTypeOffset"
        anchor="BMAP_ANCHOR_TOP_RIGHT"
      >
      </bm-map-type>
    </baidu-map>

    <div class="dataScreen-top">
      <img src="/img/dataScreen/topTitle.png" alt="" />
    </div>
    <div class="dataScreen-left"></div>
    <div class="dataScreen-right"></div>
    <div class="dataScreen-bottom">
      <div class="dataScreen-bottom-main"></div>
      <div class="dataScreen-bottom-bg">
        <img src="/img/dataScreen/bottomBg.png" alt="" />
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";

@Component({
  components: {},
})
export default class TsComp1 extends Vue {
  mapCenter: any = {
    lng: 116.404,
    lat: 39.915,
  }; // 地图中心点
  mapZoom: number = 9; // 地图缩放层级
  mapTypeOffset: any = {}; // 控件偏移值
}
</script>

<style lang="scss" scoped>
$margin: 20px; // 边距
$width: 100vw;
$boxWidth: 500px;
$height: 100vh;
$topHeight: 150px;
$bottomHeight: 260px;
$bottomBgHeight: 30px;
$boxHeight: calc(#{$height} - #{$topHeight} - #{$bottomHeight});

.dataScreen {
  width: $width;
  height: $height;

  &-map {
    width: 100%;
    height: 100%;
    position: absolute;
  }

  &-top {
    border: 1px solid red;
    box-sizing: border-box;
    width: $width;
    height: $topHeight;
    position: absolute;
    top: 0;
    z-index: 9 !important;

    img {
      width: 100%;
      height: $topHeight;
    }
  }

  &-left {
    width: $boxWidth;
    border: 1px solid green;
    box-sizing: border-box;
    position: absolute;
    top: $topHeight;
    left: $margin;
    height: $boxHeight;
  }

  &-right {
    border: 1px solid green;
    box-sizing: border-box;
    width: $boxWidth;
    height: $boxHeight;
    position: absolute;
    top: $topHeight;
    right: $margin;
  }

  &-bottom {
    width: $width;
    height: $bottomHeight;
    position: absolute;
    bottom: 0;
    display: flex;
    flex-direction: column;

    &-main {
      width: calc(100% - 2 * #{$margin});
      height: calc(#{$bottomHeight} - #{$bottomBgHeight});
      border: 1px solid red;
      margin: 0 auto;
    }

    &-bg {
      img {
        width: 100%;
        height: $bottomBgHeight;
      }
    }
  }
}

::v-deep .anchorBL {
  display: none !important;
}
</style>
