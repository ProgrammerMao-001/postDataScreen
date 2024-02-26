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
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import { getPostListByPrams } from "@/api/postModule";
import postType from "@/utils/postType";

@Component({
  components: {},
})
export default class leftComp extends Vue {
  lBox1Data: any = {
    xData: [], // ["后端开发", "前端/移动开发", "测试"]
    yData: [], // [11, 60, 20]
  };

  getLBox1Data() {
    let postTypeArr: any = []; // [{label: "后端开发", value: "1000020"}, {label: "前端/移动开发", value: "1000030"}...]
    postType()[0].subLevelModelList.forEach((item: any) => {
      // this.lBox1Data.xData.push(item.name)
      postTypeArr.push({
        label: item.name,
        value: item.code,
        num: 0,
      });
    });
    getPostListByPrams({})
      .then((res: any) => {
        /* 统计各个职位类型的数量 */
        function countJobTypes(resData: any, postTypeArr: any) {
          // 创建一个空对象用于存储统计结果
          const jobTypeCounts: any = {};

          // 遍历职位类型映射数组，初始化计数器
          for (const type of postTypeArr) {
            jobTypeCounts[type.value] = 0;
          }

          // 遍历职位数据
          for (const job of resData) {
            // 解析职位的post_type属性，并检查是否包含在映射数组中
            const jobPostTypes = JSON.parse(job.post_type);

            // 遍历职位所属的类型，累加计数
            for (const jobType of jobPostTypes) {
              if (jobType in jobTypeCounts) {
                jobTypeCounts[jobType]++;
              }
            }
          }

          // 将统计结果按照原数组顺序转换为数组形式
          return postTypeArr.map((type: any) => ({
            label: type.label,
            value: type.value,
            num: jobTypeCounts[type.value] || 0,
          }));
        }
        // 调用函数计算数量并输出结果
        const countedJobTypesArray = countJobTypes(res.data.data, postTypeArr);
        this.lBox1Data.xData = countedJobTypesArray.map(
          (num: any) => num.label
        );
        this.lBox1Data.yData = countedJobTypesArray.map((num: any) => num.num);
      })
      .finally(() => {
        this.initLBox1();
      });
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

    let myChart = (this as any).$echarts.init(document.getElementById("lBox1")); // 图标初始化
    myChart.setOption(option); // 渲染页面
    /* ECharts动态效果 */
    window.addEventListener("resize", () => {
      myChart.resize();
    });
  }

  mounted() {
    this.getLBox1Data();
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
