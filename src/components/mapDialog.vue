<!--
 * @Description: 百度地图选择点位的弹窗 页面
 * @Author: mhf
 * @Date: 2024/2/24 22:10
-->
<template>
  <div class="">
    <el-dialog
      :title="title"
      :visible.sync="dialogVisible"
      width="1000px"
      v-el-drag-dialog
      :close-on-click-modal="false"
      :before-close="hideDialog"
    >
      <div class="dialog-content">
        <div class="dialog-content-top">
          <el-input
            size="small"
            v-model="searchText"
            placeholder="输入关键字查询"
          ></el-input>
        </div>
        <baidu-map
          class="map"
          :center="{ lng: 116.404, lat: 39.915 }"
          :zoom="15"
          :scroll-wheel-zoom="true"
          @click="choosePoint"
        >
          <bm-geolocation
            anchor="BMAP_ANCHOR_BOTTOM_RIGHT"
            :showAddressBar="true"
            :autoLocation="true"
          >
          </bm-geolocation>
          <bm-local-search
            class="map-panel"
            :keyword="searchText"
            :auto-viewport="true"
          >
          </bm-local-search>
          <bm-marker
            :position="markerPoint"
            @click="infoWindowOpen"
          ></bm-marker>
        </baidu-map>
      </div>

      <span slot="footer" v-if="canEdit">
        <el-button @click="hideDialog" size="small">取 消</el-button>
        <el-button type="primary" @click="onSubmit" size="small"
          >确 定</el-button
        >
      </span>
    </el-dialog>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";

@Component({
  components: {},
})
export default class PublicDialog extends Vue {
  dialogVisible: boolean = false;
  title: string = "";
  searchText: string = "";
  markerPoint: any = {};
  showInfoWindow: boolean = false;
  markerInfo: any = "";
  canEdit: boolean = true;

  /**
   * 弹窗打开事件
   * */
  showDialog(data: any) {
    console.log(data, "data");
    this.title = data.type;
    this.dialogVisible = true;
    this.markerPoint = data.data;
    this.canEdit = data.canEdit;
    console.log(this.markerPoint, "markerPoint");
  }

  /**
   * 关闭弹窗
   * */
  hideDialog() {
    this.dialogVisible = false;
  }

  infoWindowClose() {
    this.showInfoWindow = false;
  }

  infoWindowOpen() {
    this.showInfoWindow = true;
  }

  /**
   * 地图点击事件
   * @param:
   * @return:
   * @time: 2024-02-24 22:54:38
   **/
  choosePoint(e: any) {
    this.markerPoint = e.point;
    this.getAddressByPoint(e.point.lng, e.point.lat);
  }

  getAddressByPoint(lng: any, lat: any) {
    let address,
      title = "";
    let point = new (window as any).BMap.Point(lng, lat);
    const geoc = new (window as any).BMap.Geocoder();
    geoc.getLocation(point, (rs: any) => {
      address = rs.address.toString();
      title =
        rs.surroundingPois.length > 0
          ? rs.surroundingPois[0].title.toString()
          : "";
      this.markerInfo = address + title;
    });
  }

  /**
   * 确定按钮点击
   * */
  onSubmit() {
    if (
      this.markerInfo === "" ||
      this.markerPoint.lng === "" ||
      this.markerPoint.lat === ""
    ) {
      this.$message.error("请先选择点位");
      return;
    } else {
      this.$emit("getPoint", {
        point: this.markerPoint,
        address: this.markerInfo,
      });
      this.hideDialog();
    }
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/styles/colorMap";

::v-deep .el-dialog {
  min-width: 700px !important;
}

::v-deep .el-dialog__body {
  padding: 20px !important;
}

.dialog-content {
  position: relative;

  &-top {
    position: absolute;
    top: 20px;
    left: 20px;
    z-index: 999 !important;
  }

  .map {
    width: 100%;
    height: 500px;

    &-panel {
      position: absolute;
      left: 20px;
      top: 52px;
      max-height: 400px;
      overflow-y: auto;
    }
  }
}
</style>
