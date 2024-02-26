<template>
  <div class="boxContent">
    <div class="boxContent-public">
      <div class="boxContent-public-title">职位分布情况</div>
      <div class="boxContent-public-main">
        <div id="lBox1"></div>
      </div>
    </div>

    <div class="boxContent-public">
      <div class="boxContent-public-title">职位薪资情况</div>
      <div class="boxContent-public-main"></div>
    </div>
  </div>
</template>

<script lang="ts">
import {Component, Prop, Vue, Watch} from "vue-property-decorator";
import { getPostListByPrams } from "@/api/postModule";
import postType from "@/utils/postType";


@Component({
  components: {},
})
export default class leftComp extends Vue {
  lBox1Data: any = {
    xData: [], // ["后端开发", "前端/移动开发", "测试"]
    yData: [], // [11, 60, 20]
  }

  getLBox1Data() {
    let postTypeArr = []
    postType()[0].subLevelModelList.forEach((item: any) => {
      this.lBox1Data.xData.push(item.name)
      this.lBox1Data.yData.push(0)
      postTypeArr.push({
        label: item.name,
        value: item.code
      })
    })

    getPostListByPrams({}).then((res: any) => {
      console.log(res.data.data, "res")
    })

  }

  initLBox1() {
    let option: any = {
      tooltip: {
        trigger: "axis",
      },
      grid: {
        top: "14%",
        bottom: "15%",
      },
      xAxis: [
        {
          type: "category",
          data: this.lBox1Data.xData,
          axisLine: {
            lineStyle: {
              color: "#fff",
            },
          },
        },
      ],
      yAxis: [
        {
          type: "value",
          splitNumber: 4,
          splitLine: {
            show: false,
            lineStyle: {
              type: "dashed",
              color: "#DDD",
            },
          },
          axisLine: {
            show: false,
            lineStyle: {
              color: "#fff",
            },
          },
          nameTextStyle: {
            color: "#999",
          },
          splitArea: {
            show: false,
          },
        },
      ],
      series: [
        {
          name: "岗位数",
          type: "line",
          data: this.lBox1Data.yData,
          lineStyle: {
            normal: {
              width: 2, // 线条粗细
              color: {
                type: "linear",

                colorStops: [
                  {
                    offset: 0,
                    color: "#A9F387", // 0% 处的颜色
                  },
                  {
                    offset: 1,
                    color: "#48D8BF", // 100% 处的颜色
                  },
                ],
                globalCoord: false, // 缺省为 false
              },
              shadowColor: "rgba(72,216,191, 0.3)",
              shadowBlur: 10,
              shadowOffsetY: 20,
            },
          },
          itemStyle: {
            normal: {
              color: "#48D8BF",
              borderWidth: 10,
            },
          },
          smooth: true,
        },
      ],
    };

    let myChart = (this as any).$echarts.init(
        document.getElementById("lBox1")
    ); // 图标初始化
    myChart.setOption(option); // 渲染页面
    /* ECharts动态效果 */
    window.addEventListener("resize", () => {
      myChart.resize();
    });
  }

  mounted() {
    this.getLBox1Data()
    this.initLBox1()
  }
}
</script>

<style lang="scss" scoped>
@import "publicStyle";

#lBox1 {
  width: 100%;
  height: 100%;
}
</style>
