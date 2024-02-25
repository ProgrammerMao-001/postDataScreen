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
        style="
          position: absolute;
          z-index: 9999 !important;
          border: 2px solid red;
        "
        :map-types="['BMAP_NORMAL_MAP', 'BMAP_HYBRID_MAP']"
        :offset="mapTypeOffset"
        anchor="BMAP_ANCHOR_TOP_RIGHT"
      >
      </bm-map-type>
    </baidu-map>

    <div class="dataScreen-top">
      <img src="/img/dataScreen/topTitle.png" alt="" />
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
import bottomComp from "@/views/dataScreen/bottomComp.vue";
import leftComp from "@/views/dataScreen/leftComp.vue";
import rightComp from "@/views/dataScreen/rightComp.vue";

@Component({
  components: { bottomComp, leftComp, rightComp },
})
export default class dataScreen extends Vue {
  mapCenter: any = {
    lng: 116.404,
    lat: 39.915,
  }; // 地图中心点
  mapZoom: number = 9; // 地图缩放层级
  mapTypeOffset: any = {
    width: 440,
    height: 128,
  }; // 控件偏移值
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

    img {
      width: 100%;
      height: $topHeight;
    }
  }

  &-left {
    width: $boxWidth;
    position: absolute;
    top: $topHeight;
    left: $margin;
    height: $boxHeight;
  }

  &-right {
    width: $boxWidth;
    height: $boxHeight;
    position: absolute;
    top: $topHeight;
    right: $margin;
  }

  &-bottom {
    height: $bottomHeight;
    position: absolute;
    left: $margin;
    right: $margin;
    bottom: 0;
  }
}

::v-deep .anchorBL {
  display: none !important;
}
</style>
