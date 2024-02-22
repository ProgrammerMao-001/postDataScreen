<template>
  <div class="container">
    <div class="img-box">
      <div class="back-home" @click="$router.push('/')">返 回 首 页</div>
      <img src="../../assets/pic/404.jpg" alt="" />
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";

@Component({
  components: {},
})
export default class NotFound extends Vue {}
</script>

<style lang="scss" scoped>
.container {
  width: 100%;
  height: 100%;
  position: relative;

  .img-box {
    width: 819px;
    height: 417px;
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    margin: auto;

    img {
      width: 100%;
      height: 100%;
    }

    .back-home {
      font-size: 18px;
      width: 100px;
      height: 23px;
      cursor: pointer;
      position: absolute;
      bottom: -40px;
      left: 299px;
      border: 1px solid #d7dae2;
      border-radius: 20px;
      text-align: center;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.12), 0 0 6px rgba(0, 0, 0, 0.04);
      padding: 4px 10px;
      color: #666;

      &:hover {
        color: #2244ff;
      }
    }
  }
}
</style>
