<!--
 * @Description: 词云组件 页面
 * @Date: 2024/3/10 23:39
-->
<template>
  <div
    :style="{
      display: 'flex',
      justifyContent: 'center',
      border: '1px solid red',
    }"
  >
    <svg
      :width="width"
      :height="height"
      @mousemove="listener($event)"
      @mouseout="listener1($event)"
      @mouseover="listener2($event)"
    >
      <a
        href="#"
        v-for="(tag, index) in tags"
        :key="index"
        @click="showOptionsAndResult(tag.text)"
      >
        <text
          :x="tag.x"
          :y="tag.y"
          :font-size="7 * (1000 / (800 - tag.z * 2))"
          :font-weight="550"
          :fill-opacity="(600 + tag.z) / 800"
          :style="style(tag)"
        >
          {{ tag.text }}
        </text>
      </a>
    </svg>
  </div>
</template>

<script>
export default {
  props: {
    width: {
      type: Number,
      default: 600,
    },
    height: {
      type: Number,
      default: 600,
    },
    radius: {
      type: Number,
      default: 200,
    },
  },
  data() {
    return {
      speedX: Math.PI / 1800,
      speedY: Math.PI / 1800,
      tags: [],
      colorList: [
        "#e27027",
        "#cc7b2e",
        "#ad4331",
        "#88343b",
        "#d4902f",
        "#c7a736",
        "#8d7a3d",
        "#8d7a3d",
        "#d9b134",
      ],
      CXNum: 2,
      CYNum: 2,
    };
  },
  computed: {
    CX() {
      return this.width / this.CXNum;
    },
    CY() {
      return this.height / this.CYNum;
    },
  },
  mounted() {
    let _this = this;
    window.addEventListener(
      "resize",
      () => {
        let normalWidth = document.body.scrollWidth;
        _this.screenWidth = normalWidth;
        if (normalWidth <= 1550) {
          _this.CXNum = 2.7;
          _this.CYNum = 1.9;
        } else {
          _this.CXNum = 2.5;
          _this.CYNum = 1.8;
        }
      },
      false
    );
    setInterval(() => {
      this.rotateX(this.speedX);
      this.rotateY(this.speedY);
    }, 17);
  },
  methods: {
    rotateX(angleX) {
      var cos = Math.cos(angleX);
      var sin = Math.sin(angleX);
      for (let tag of this.tags) {
        var y1 = (tag.y - this.CY) * cos - tag.z * sin + this.CY;
        var z1 = tag.z * cos + (tag.y - this.CY) * sin;
        tag.y = y1;
        tag.z = z1;
      }
    },
    rotateY(angleY) {
      var cos = Math.cos(angleY);
      var sin = Math.sin(angleY);
      for (let tag of this.tags) {
        var x1 = (tag.x - this.CX) * cos - tag.z * sin + this.CX;
        var z1 = tag.z * cos + (tag.x - this.CX) * sin;
        tag.x = x1;
        tag.z = z1;
      }
    },
    listener(event) {
      var x = event.clientX - this.CX;
      var y = event.clientY - this.CY;
      this.speedX =
        x * 0.0001 > 0
          ? Math.min(this.radius * 0.00002, x * 0.0001)
          : Math.max(-this.radius * 0.00002, x * 0.0001);
      this.speedY =
        y * 0.0001 > 0
          ? Math.min(this.radius * 0.00002, y * 0.0001)
          : Math.max(-this.radius * 0.00002, y * 0.0001);
    },
    listener1(e) {
      this.speedX = Math.PI / 1800;
      this.speedY = Math.PI / 1800;
    },
    listener2(e) {
      this.speedX = 0;
      this.speedY = 0;
    },
    showOptionsAndResult(text) {
      this.$emit("showOptionsAndResult", true, text, "", "");
    },
    style(tag) {
      return `fill:${tag.color};`;
    },
    calculation3DWord(radius = "") {
      let tags = [];
      for (let i = 0; i < this.tags.length; i++) {
        let tag = {};
        let k = -1 + (2 * (i + 1) - 1) / this.tags.length;
        let a = Math.acos(k);
        let b = a * Math.sqrt(this.tags.length * Math.PI);
        tag.text =
          typeof this.tags[i] === "string" ? this.tags[i] : this.tags[i].text;
        if (radius === "") {
          tag.x = this.CX + this.radius * Math.sin(a) * Math.cos(b);
          tag.y = this.CY + this.radius * Math.sin(a) * Math.sin(b);
          tag.z = this.radius * Math.cos(a);
        } else {
          tag.x = 150 * (radius / 120) + radius * Math.sin(a) * Math.cos(b);
          tag.y = 150 * (radius / 120) + radius * Math.sin(a) * Math.sin(b);
          tag.z = radius * Math.cos(a);
        }
        if (i <= this.colorList.length - 1) {
          tag.color = this.colorList[i];
        } else {
          tag.color =
            i % this.colorList.length === 0
              ? this.colorList[0]
              : this.colorList[i % this.colorList.length];
        }
        tags.push(tag);
      }
      this.tags.splice(0);
      this.tags = tags;
    },
    setTags(tags = []) {
      this.tags.splice(0);
      this.tags.push(...tags);
      this.calculation3DWord();
    },
  },
};
</script>

<style></style>
