<!--
 * @Description: 驾驶舱 页面

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
      <bml-marker-clusterer :averageCenter="true">
        <bm-marker
          v-for="item in companyList"
          :key="item.id"
          :position="JSON.parse(item.position)"
          :icon="getIconStyle(item)"
          @mouseover="markerOver(item)"
          @mouseout="markerOut(item)"
          @click="showCompanyDialog(item)"
        >
          <bm-label
            v-if="item.showMarker"
            :content="item.name"
            :labelStyle="{}"
            :offset="{ width: -35, height: 30 }"
          >
          </bm-label>
        </bm-marker>
      </bml-marker-clusterer>
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
    <companyDetailDialog ref="companyDetailDialog" />
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import topComp from "@/views/dataScreen/topComp.vue";
import bottomComp from "@/views/dataScreen/bottomComp.vue";
import leftComp from "@/views/dataScreen/leftComp.vue";
import rightComp from "@/views/dataScreen/rightComp.vue";
import { BmlMarkerClusterer } from "vue-baidu-map";
import companyDetailDialog from "@/views/dataScreen/companyDetailDialog.vue";

import { getCompanyListByPrams } from "@/api/companyModule";

@Component({
  components: {
    topComp,
    bottomComp,
    leftComp,
    rightComp,
    BmlMarkerClusterer,
    companyDetailDialog,
  },
})
export default class dataScreen extends Vue {
  mapCenter: any = {
    lng: 116.404,
    lat: 39.915,
  }; // 地图中心点
  mapZoom: number = 9; // 地图缩放层级
  mapType: string = "BMAP_HYBRID_MAP"; // 地图类型
  companyList: any = []; // 公司列表

  changeMapType(type: any) {
    this.mapType = type;
  }

  getIconStyle(item: any) {
    let size: object = {
      width: 40,
      height: 40,
    };
    let url =
      item.photos ||
      "http://data-screen.fangdafu.com/data-screen/img/base/houseDaFu/city.png";
    return {
      url,
      size,
      opts: { imageSize: size },
    };
  }

  getCompanyList() {
    getCompanyListByPrams({}).then((res: any) => {
      this.companyList = res.data.data;
    });
  }

  /* 鼠标移入点位 */
  markerOver(obj: any) {
    this.$nextTick(() => {
      this.$set(obj, "showMarker", true);
    });
  }

  /* 鼠标移出点位 */
  markerOut(obj: any) {
    this.$nextTick(() => {
      this.$set(obj, "showMarker", false);
    });
  }

  /* 打开公司详情 */
  showCompanyDialog(item: any) {
    this.mapCenter = JSON.parse(item.position);
    this.mapZoom = 15;
    (this.$refs.companyDetailDialog as any).showDialog({
      data: item,
      type: "详情",
    });
  }

  created() {
    this.getCompanyList();
  }

  mounted() {}
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
$boxHeight: calc(#{$height} - #{$topHeight} + #{$margin});

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
    width: calc(#{$width - #{$margin} * 4 - #{$boxWidth} * 2});
    height: $bottomHeight;
    position: absolute;
    left: 0;
    right: 0;
    bottom: $margin;
    margin: auto;
  }
}

::v-deep .anchorBL {
  display: none !important;
}
</style>
