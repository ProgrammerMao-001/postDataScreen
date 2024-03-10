<template>
  <div class="boxContent">
    <div class="boxContent-public">
      <div class="boxContent-public-title">不同经验职位情况</div>
      <div class="boxContent-public-main">
        <div id="lBox3"></div>
      </div>
    </div>

    <div class="boxContent-public">
      <div class="boxContent-public-title">不同学历职位情况</div>
      <div class="boxContent-public-main">
        <div id="lBox4"></div>
      </div>
    </div>

    <div class="boxContent-public">
      <div class="boxContent-public-title">职位{{ radioValue }}情况</div>
      <div class="boxContent-public-main">
        <div id="lBox1" v-if="radioValue === '数量'"></div>
        <div id="lBox2" v-if="radioValue === '薪资'"></div>

        <div class="check">
          <el-radio-group
            size="small"
            v-model="radioValue"
            @change="radioChange"
          >
            <el-radio-button label="薪资"></el-radio-button>
            <el-radio-button label="数量"></el-radio-button>
          </el-radio-group>
        </div>
      </div>
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

  lBox2Data: any = {
    xData: [], // ["后端开发", "前端/移动开发", "测试"]
    yData: [], // [11, 60, 20]
  };

  radioValue: string = "薪资";

  getLBoxData() {
    let postTypeArr: any = []; // [{label: "后端开发", value: "1000020"}, {label: "前端/移动开发", value: "1000030"}...]
    postType()[0].subLevelModelList.forEach((item: any) => {
      // this.lBox1Data.xData.push(item.name)
      postTypeArr.push({
        label: item.name,
        value: item.code,
        num: 0,
        avgArr: [], // 平均薪资
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
        this.lBox2Data.xData = countedJobTypesArray.map(
          (num: any) => num.label
        );
        this.lBox1Data.yData = countedJobTypesArray.map((num: any) => num.num);

        /* 计算平均薪资 */
        function mapAverageRanges(resData: any, postTypeArr: any) {
          // 遍历职位数据数组
          resData.forEach((job: any) => {
            const jobPostTypes = JSON.parse(job.post_type);
            // 遍历职位类型映射数组
            jobPostTypes.forEach((value: any) => {
              const matchingPostType = postTypeArr.find(
                (postType: any) => postType.value === value
              );

              // 如果找到匹配项，则将平均薪资范围添加到avgArr中
              if (matchingPostType) {
                matchingPostType.avgArr.push(job.avg_range);
              }
            });
          });

          return postTypeArr;
        }
        let resAvgArr: any = mapAverageRanges(res.data.data, postTypeArr);
        resAvgArr.forEach((item: any, index: any) => {
          item.avg =
            item.avgArr.length > 0
              ? (
                  item.avgArr.reduce(
                    (a: number, b: number) => Number(a) + Number(b),
                    0
                  ) / item.avgArr.length
                ).toFixed(2)
              : 0.0;
        });
        this.lBox2Data.yData = resAvgArr.map((num: any) => num.avg);
      })
      .finally(() => {
        if (this.radioValue === "数量") {
          this.initLBox1();
        } else if (this.radioValue === "薪资") {
          this.initBox2();
        }
      });
  }

  initLBox1() {
    let option: any = {
      title: {
        text: "岗位数(个)",
        textStyle: {
          align: "left",
          color: "#fff",
          fontSize: 12,
        },
        top: "5%",
        left: "left",
      },
      tooltip: {
        trigger: "axis",
      },
      grid: {
        top: "18%",
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
          minInterval: 1,
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
          axisLabel: {}, // 自定义y轴文字样式
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
                    color: "#38bcf3", // 0% 处的颜色
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

  initBox2() {
    let option = {
      backgroundColor: "",
      title: {
        text: "平均薪资(K)",
        textStyle: {
          align: "left",
          color: "#fff",
          fontSize: 12,
        },
        top: "5%",
        left: "left",
      },
      tooltip: {
        trigger: "axis",
        axisPointer: {
          type: "shadow",
        },
        formatter: "{b}：{c}",
      },
      grid: {
        top: "18%",
        bottom: "15%",
      },
      xAxis: [
        {
          type: "category",
          data: this.lBox2Data.xData,
          axisLine: {
            lineStyle: {
              color: "rgba(255,255,255,0.12)",
            },
          },
          axisLabel: {
            margin: 10,
            color: "#e2e9ff",
            textStyle: {
              fontSize: 14,
            },
          },
        },
      ],
      yAxis: [
        {
          axisLabel: {
            formatter: "{value}",
            color: "#e2e9ff",
          },
          axisLine: {
            show: false,
          },
          splitLine: {
            lineStyle: {
              color: "rgba(255,255,255,0.12)",
            },
          },
        },
      ],
      series: [
        {
          type: "bar",
          data: this.lBox2Data.yData,
          barWidth: "20px",
          itemStyle: {
            normal: {
              color: new (this as any).$echarts.graphic.LinearGradient(
                0,
                0,
                0,
                1,
                [
                  {
                    offset: 0,
                    color: "rgba(0,244,255,.5)", // 0% 处的颜色
                  },
                  {
                    offset: 1,
                    color: "rgba(42,132,136,0.5)", // 100% 处的颜色
                  },
                ],
                false
              ),
              barBorderRadius: [8, 8, 0, 0],
              shadowColor: "rgba(0,160,221,.8)",
              shadowBlur: 4,
            },
          },
        },
      ],
    };

    let myChart = (this as any).$echarts.init(document.getElementById("lBox2")); // 图标初始化
    myChart.setOption(option); // 渲染页面
    /* ECharts动态效果 */
    window.addEventListener("resize", () => {
      myChart.resize();
    });
  }

  radioChange() {
    this.getLBoxData();
  }

  async getBox3() {
    /* 获取岗位列表 */
    let postArr: any = await getPostListByPrams({});
    console.log(postArr.data.data, "postArr");
    /* 获取工作经验列表 */
    let workExperienceArr = await (this as any).getDict("workExperience")
    let helpWorkArr = workExperienceArr.data.data[0]?.data || "[]";
    let xData = JSON.parse(helpWorkArr).map((e: any) => e.label)

    console.log(JSON.parse(helpWorkArr), "helpWorkArr")
    this.initLBox3({
      legendData: ["岗位数", "薪资"],
      xData: xData,
      barData: [
        2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3,
      ],
      lineData: [
        2.0, 2.2, 3.3, 4.5, 6.3, 10.2, 20.3, 23.4, 23.0, 16.5, 12.0, 6.2,
      ],
    });
  }

  initLBox3(params: any = {}) {
    let { legendData = [], xData = [], barData = [], lineData = [] } = params;
    let option: any = {
      tooltip: {
        trigger: "axis",
      },
      grid: {
        top: "18%",
        bottom: "15%",
      },
      toolbox: {},
      legend: {
        top: 10,
        textStyle: {
          color: "#fff",
        },
        data: legendData,
      },
      xAxis: [
        {
          type: "category",
          data: xData,
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
          name: "岗位数(个)",
          min: 0,
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
          axisLabel: {
            formatter: "{value}",
          },
        },
        {
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
          type: "value",
          name: "薪资(K)",
          min: 0,
          axisLabel: {
            formatter: "{value}",
          },
        },
      ],
      series: [
        {
          name: "岗位数",
          type: "bar",
          tooltip: {
            valueFormatter: function (value: any) {
              return value + " 个";
            },
          },
          data: barData, // 柱状图的数据 岗位数
          barWidth: "20px",
          itemStyle: {
            normal: {
              color: new (this as any).$echarts.graphic.LinearGradient(
                0,
                0,
                0,
                1,
                [
                  {
                    offset: 0,
                    color: "rgba(0,244,255,.5)", // 0% 处的颜色
                  },
                  {
                    offset: 1,
                    color: "rgba(42,132,136,0.5)", // 100% 处的颜色
                  },
                ],
                false
              ),
              barBorderRadius: [8, 8, 0, 0],
              shadowColor: "rgba(0,160,221,.8)",
              shadowBlur: 4,
            },
          },
        },
        {
          name: "薪资",
          type: "line",
          yAxisIndex: 1,
          tooltip: {
            valueFormatter: function (value: any) {
              return value + " K";
            },
          },
          data: lineData, // 折线图的数据 薪资
          lineStyle: {
            normal: {
              width: 2, // 线条粗细
              color: {
                type: "linear",

                colorStops: [
                  {
                    offset: 0,
                    color: "#38bcf3", // 0% 处的颜色
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
    let myChart = (this as any).$echarts.init(document.getElementById("lBox3"));
    myChart.setOption(option); // 渲染页面
    /* ECharts动态效果 */
    window.addEventListener("resize", () => {
      myChart.resize();
    });
  }

  mounted() {
    this.getLBoxData();
    this.getBox3();
  }
}
</script>

<style lang="scss" scoped>
@import "publicStyle";

#lBox1,
#lBox2,
#lBox3,
#lBox4 {
  width: 100%;
  height: 100%;
}

.check {
  position: absolute;
  top: 40px;
  right: 10px;
}

::v-deep .el-radio-button__inner,
.el-radio-group {
  height: 14px;
  line-height: 0px;
}

::v-deep .el-radio-button__orig-radio:checked + .el-radio-button__inner {
  background-color: $deepBgColor;
  border-color: $deepBgColor;
}
</style>
