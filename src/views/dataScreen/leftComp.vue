<template>
  <div class="boxContent">
    <div class="boxContent-public">
      <div class="boxContent-public-title">不同经验职位</div>
      <div class="boxContent-public-main">
        <div id="lBox3"></div>
      </div>
    </div>

    <div class="boxContent-public">
      <div class="boxContent-public-title">不同学历职位</div>
      <div class="boxContent-public-main">
        <div v-if="box4RadioValue === '对比图'" id="lBox4"></div>
        <div v-if="box4RadioValue === '饼图'" id="lBox5"></div>

        <div class="check">
          <el-radio-group
            size="small"
            v-model="box4RadioValue"
            @change="box4RadioChange"
          >
            <el-radio-button label="对比图"></el-radio-button>
            <el-radio-button label="饼图"></el-radio-button>
          </el-radio-group>
        </div>
      </div>
    </div>

    <div class="boxContent-public">
      <div class="boxContent-public-title">不同职位{{ radioValue }}</div>
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
  box4RadioValue: string = "对比图";
  box5Data: any = {
    data: [],
    total: 0,
  };
  option: any = {};
  myChart: any = null;

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

  async box4RadioChange() {
    if (this.box4RadioValue === "对比图") {
      await this.myChart.dispose();
      await this.getBox4();
    } else if (this.box4RadioValue === "饼图") {
      await this.myChart.dispose();
      await this.getBox5();
    }
  }

  async getBox3() {
    /* 获取岗位列表 */
    let postArr: any = await getPostListByPrams({});
    console.log(postArr.data.data, "postArr");
    /* 获取工作经验列表 */
    let workExperienceArr = await (this as any).getDict("workExperience");
    let helpWorkArr = workExperienceArr.data.data[0]?.data || "[]";
    let xData = JSON.parse(helpWorkArr).map((e: any) => e.label);
    let helpPostArr = postArr.data.data; // 岗位列表

    let helpWorkArr1 = JSON.parse(helpWorkArr); // 在校生、应届生...经验字典
    function getBarData() {
      // 初始化一个对象用于存储教育程度与数量
      const workLifeCounts: any = {};
      // 遍历 helpWorkArr 并统计或初始化数量
      helpWorkArr1.forEach((workItem: any) => {
        const workLife = workItem.value;
        workLifeCounts[workItem.label] =
          helpPostArr.filter((post: any) => post.work_life === workLife)
            .length || 0;
      });
      // 按照 helpWorkArr 的顺序输出统计结果
      const output = helpWorkArr1.map((workItem: any) => ({
        label: workItem.label,
        count: workLifeCounts[workItem.label],
      }));
      return output.map((e: any) => e.count) || [];
    }

    function getLineData() {
      // 初始化一个对象用于存储教育程度与平均范围数组
      const workLifeAvgRanges: any = {};

      // 遍历 helpWorkArr1 并统计平均范围
      helpWorkArr1.forEach((workItem: any) => {
        const workLife = workItem.value;
        workLifeAvgRanges[workItem.label] = helpPostArr
          .filter((post: any) => post.work_life === workLife)
          .map((post: any) => parseFloat(post.avg_range) || 0);
      });

      // 如果需要将不存在的数据表示为一个空数组，可以进一步处理：
      Object.keys(workLifeAvgRanges).forEach((key) => {
        if (!workLifeAvgRanges[key].length) {
          workLifeAvgRanges[key] = [];
        }
      });

      // 按照 helpWorkArr1 的顺序生成并填充平均值到新数组中
      const resultWithAveragesInOrder = helpWorkArr1.reduce(
        (acc: any, workItem: any) => {
          const avgRangeArray = workLifeAvgRanges[workItem.label];
          if (avgRangeArray.length > 0) {
            // 如果有数据，则计算平均值并保留两位小数
            const average = parseFloat(
              (
                avgRangeArray.reduce((total: any, num: any) => total + num, 0) /
                avgRangeArray.length
              ).toFixed(2)
            );
            acc.push({ label: workItem.label, average });
          } else {
            // 如果没有数据，则设置为 0
            acc.push({ label: workItem.label, average: 0 });
          }
          return acc;
        },
        []
      );

      return resultWithAveragesInOrder.map((item: any) => item.average) || [];
    }
    this.initLBox3({
      legendData: ["岗位数", "平均薪资"],
      xData: xData,
      barData: getBarData(),
      lineData: getLineData(),
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
        left: 80,
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
          name: "平均薪资(K)",
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
          name: "平均薪资",
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

  async getBox4() {
    /* 学历列表 */
    const educationResponse = await (this as any).getDict("education");
    let arr = educationResponse.data.data[0].data || "[]";
    let educationList: any = JSON.parse(arr);
    /* 岗位列表 */
    const postListResponse: any = await getPostListByPrams({
      name: undefined,
    });
    let postList: any = postListResponse.data.data;

    /* 统计 postList 中education 0 -7 的数量 */
    const educationCount = postList.reduce((acc: any, curr: any) => {
      const educationLevel = parseInt(curr.education, 10);
      if (educationLevel >= 0 && educationLevel <= 7) {
        acc[educationLevel] = (acc[educationLevel] || 0) + 1;
      }
      return acc;
    }, {});

    /* 没有数据的也统计上面 */
    educationList.sort(
      (a: any, b: any) => parseInt(a.value, 10) - parseInt(b.value, 10)
    );
    const transformedData = educationList.map((mappingItem: any) => {
      const key = mappingItem.value;
      const count = educationCount[key] || 0;
      return {
        name: mappingItem.label,
        value: count,
      };
    });
    // console.log(transformedData, "transformedData");

    function getAvgArr() {
      // 初始化一个对象用于存储教育程度与平均范围数组
      const educationAvgRanges: any = {};

      // 遍历 postList 并填充对应教育程度的平均范围数组
      postList.forEach((post: any) => {
        const educationValue = post.education;
        if (educationAvgRanges[educationValue]) {
          educationAvgRanges[educationValue].push(parseFloat(post.avg_range));
        } else {
          educationAvgRanges[educationValue] = [parseFloat(post.avg_range)];
        }
      });

      // 按照 educationList 的顺序生成并填充平均值到新数组中
      const resultWithAveragesInOrder = educationList.reduce(
        (acc: any, educationItem: any) => {
          const avgRangeArray: any =
            educationAvgRanges[educationItem.value] || [];
          let average: any = 0.0;
          if (avgRangeArray.length > 0) {
            let avg: any =
              avgRangeArray.reduce((total: any, num: any) => total + num, 0) /
              avgRangeArray.length;
            average = parseFloat(avg).toFixed(2);
          }
          acc.push({
            label: educationItem.label,
            avg_range_array: avgRangeArray,
            average,
          });
          return acc;
        },
        []
      );

      // 输出按顺序的结果
      // console.log(resultWithAveragesInOrder, "resultWithAveragesInOrder");
      return resultWithAveragesInOrder.map((item: any) => item.average) || [];
    }

    getAvgArr();
    this.initLBox4({
      legendData: ["岗位数", "平均薪资"],
      xData: transformedData.map((item: any) => item.name) || [],
      barData: transformedData.map((item: any) => item.value) || [],
      lineData: getAvgArr(),
    });
  }

  initLBox4(params: any = {}) {
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
        left: 80,
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
          // name: "平均薪资(K)",
          min: 0,
          axisLabel: {
            show: false,
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
          name: "平均薪资",
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
    this.myChart = (this as any).$echarts.init(
      document.getElementById("lBox4")
    );
    this.myChart.setOption(option); // 渲染页面
    /* ECharts动态效果 */
    window.addEventListener("resize", () => {
      this.myChart.resize();
    });
  }

  initLBox5() {
    this.option = {
      backgroundColor: "",
      animation: true,
      title: {
        text: this.box5Data.total, // 中间展示的数字
        subtext: "岗位数",
        x: "center",
        y: "center",
        textStyle: {
          color: "#fff",
          fontSize: 20,
          fontWeight: "normal",
          align: "center",
        },
        subtextStyle: {
          color: "#fff",
          fontSize: 12,
          fontWeight: "normal",
        },
      },
      series: [
        {
          type: "pie",
          center: ["50%", "50%"],
          radius: ["40%", "53%"],
          color: [
            "#FEE449",
            "#00FFFF",
            "#00FFA8",
            "#9F17FF",
            "#FFE400",
            "#F76F01",
            "#01A4F7",
            "#FE2C8A",
          ],
          startAngle: 135,
          labelLine: {
            normal: {
              length: 10,
            },
          },
          label: {
            normal: {
              formatter: "{b|{b}:}  {c|{c}人}",
              backgroundColor: "rgba(255, 147, 38, 0)",
              borderColor: "transparent",
              borderRadius: 4,
              rich: {
                hr: {
                  borderColor: "#aaa",
                  width: "100%",
                  borderWidth: 1,
                  height: 0,
                },
                b: {
                  color: "#b3e5ff",
                  fontSize: 14,
                  lineHeight: 33,
                },
                c: {
                  fontSize: 14,
                  color: "#eee",
                },
              },
              textStyle: {
                color: "#fff",
                fontSize: 6,
              },
            },
          },
          data: this.box5Data.data,
        },
        {
          type: "pie",
          center: ["50%", "50%"],
          radius: ["35%", "36%"],
          label: {
            show: false,
          },
          data: [],
        },
      ],
    };

    this.myChart = (this as any).$echarts.init(
      document.getElementById("lBox5")
    ); // 图标初始化
    this.myChart.setOption(this.option); // 渲染页面
    /* ECharts动态效果 */
    this.myChart.addEventListener("resize", () => {
      this.myChart.resize();
    });
  }

  async getBox5() {
    try {
      /* 学历列表 */
      const educationResponse = await (this as any).getDict("education");
      let arr = educationResponse.data.data[0].data || "[]";
      let educationList: any = JSON.parse(arr);
      /* 岗位列表 */
      const postListResponse: any = await getPostListByPrams({
        name: undefined,
      });
      let postList: any = postListResponse.data.data;

      /* 统计 postList 中education 0 -7 的数量 */
      const educationCount = postList.reduce((acc: any, curr: any) => {
        const educationLevel = parseInt(curr.education, 10);
        if (educationLevel >= 0 && educationLevel <= 7) {
          acc[educationLevel] = (acc[educationLevel] || 0) + 1;
        }
        return acc;
      }, {});

      /* 没有数据的也统计上面 */
      educationList.sort(
        (a: any, b: any) => parseInt(a.value, 10) - parseInt(b.value, 10)
      );
      const transformedData = educationList.map((mappingItem: any) => {
        const key = mappingItem.value;
        const count = educationCount[key] || 0;
        return {
          name: mappingItem.label,
          value: count,
        };
      });
      this.box5Data.data = transformedData;
      this.box5Data.total = transformedData.reduce(
        (accumulator: any, currentItem: any) => {
          return accumulator + currentItem.value;
        },
        0
      );

      // console.log(this.box2Data, "box2Data");
      await this.initLBox5();
      // console.log(transformedData, "transformedData") [{name: '初中及以下', value: 0}, ...]
    } catch (error) {
      // 处理错误
      console.error("Error fetching data2:", error);
    }
  }

  mounted() {
    this.getLBoxData();
    this.getBox3();
    this.getBox4();
  }
}
</script>

<style lang="scss" scoped>
@import "publicStyle";

#lBox1,
#lBox2,
#lBox3,
#lBox4,
#lBox5 {
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
