<template>
  <div class="topComp">
    <div
      class="topComp-left"
      :style="{ color: mapId === 0 ? '#fff' : '#409eff' }"
    >
      {{ time }}
    </div>

    <div class="topComp-right">
      <img
        v-for="(item, index) in mapTypeArr"
        :key="index"
        :src="item.img"
        :title="item.label"
        :alt="item.label"
        @click="changeMapType(item)"
      />
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";

@Component({
  components: {},
})
export default class topComp extends Vue {
  time: any = new Date().toLocaleDateString().split("/").join("-");
  timer: any = null;
  mapTypeArr: any = [
    {
      id: 0,
      label: "卫星和路网的混合视图",
      value: "BMAP_HYBRID_MAP",
      img: "/img/dataScreen/satellite.png",
    },
    {
      id: 1,
      label: "普通街道视图",
      value: "BMAP_NORMAL_MAP",
      img: "/img/dataScreen/vector.png",
    },
  ];
  mapId: any = 0;

  getTime() {
    this.time = new Date().toLocaleString().split("/").join("-");
  }

  changeMapType(obj: any) {
    (this.$parent as any).changeMapType(obj.value);
    this.mapId = obj.id;
  }

  created() {
    this.timer = setInterval(() => {
      this.getTime();
    }, 1000);
  }

  destroy() {
    clearInterval(this.timer);
    this.timer = null;
  }
}
</script>

<style lang="scss" scoped>
$width: 400px;
$margin: 20px;

.topComp {
  width: 100%;
  height: 100%;
  background-image: url("/public/img/dataScreen/topTitle.png");
  background-repeat: no-repeat;
  background-size: 100% 100%;
  background-position: center;
  display: flex;
  justify-content: space-between;
  align-items: center;
  cursor: pointer;

  &-left {
    width: $width;
    height: 50px;
    margin-left: $margin;
    color: #edf4ff;
    font-size: 18px;
    font-weight: 700;
    line-height: 50px;
  }

  &-right {
    width: $width;
    height: 50px;
    margin-right: $margin;
    display: flex;
    align-items: center;
    flex-direction: row-reverse;

    img {
      width: 40px;
      height: 40px;
      border-radius: 4px;
      cursor: pointer;
      margin-left: $margin / 2;
      box-shadow: 0 0 2px #000;

      &:hover {
        box-shadow: 0 0 5px #000;
      }
    }
  }
}
</style>
