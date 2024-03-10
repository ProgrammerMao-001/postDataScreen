<template>
  <div class="boxContent">
    <div class="boxContent-public">
      <div class="boxContent-public-title">职位需求情况</div>
      <div class="boxContent-public-main">
        <div id="rBox1"></div>
      </div>
    </div>

    <div class="boxContent-public">
      <div class="boxContent-public-title">职位招聘情况</div>
      <div class="boxContent-public-main">
        <div id="rBox2"></div>
      </div>
    </div>

    <div class="boxContent-public">
      <div class="boxContent-public-title">词云</div>
      <div class="boxContent-public-main">
        <div id="rBox3">
          <wordCloud
            ref="wordCloud"
            :width="rBox3.width"
            :height="rBox3.height"
          />
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import { getPostListByPrams } from "@/api/postModule";
import postType from "@/utils/postType";
import wordCloud from "@/views/dataScreen/wordCloud.vue";

@Component({
  components: { wordCloud },
})
export default class rightComp extends Vue {
  myChart: any = null;
  provinceList: any = []; // 省份列表
  box1Data: any = {
    xAxisData: [],
    dataList: [],
  };
  rBox3: any = {
    width: 0,
    height: 0,
  };

  /* 获取rBox1数据 (分析不同地区的不同职位的总数【互联网/AI行业】。如：在浙江、湖南等后端开发、人工智能等的岗位数) */
  async getRBox1Data() {
    try {
      /* 省份列表 */
      const provinceResponse = await (this as any).getDict("province");
      let arr = provinceResponse.data.data[0].data || "[]";
      this.provinceList = JSON.parse(arr);
      let provinceArr: any = this.provinceList.map((item: any) => item.label);
      this.box1Data.xAxisData = provinceArr;
      /* 岗位列表 */
      const postListResponse: any = await getPostListByPrams({
        name: undefined,
      });
      let postList = postListResponse.data.data;
      /* 获取 互联网/AI行业 类型的岗位数据 */
      let aiArr = postList.filter((obj: any) => {
        if (obj.post_type) {
          let arr = JSON.parse(obj.post_type);
          return arr[0] == 1010000;
        }
      });
      /* 获取 互联网/AI行业 的字典数据 */
      let aiDict: any = postType()[0].subLevelModelList.map((item: any) => {
        return { label: item.name, value: item.code };
      });

      /* 获取最终的二维数组即rBox1数据 */
      // 初始化结果数组，长度为 aiDict 的长度，每个项的长度为 provinceArr 的长度，初始值为 0
      const result = new Array(aiDict.length)
        .fill(0)
        .map(() => new Array(provinceArr.length).fill(0));

      // 遍历 aiArr 中的每个数据项，统计各个省份对应的后端开发和前端/移动开发的数量
      aiArr.forEach((item: any) => {
        const provinceIndex = provinceArr.indexOf(item.company_province);
        if (provinceIndex !== -1) {
          const postTypes = JSON.parse(item.post_type);
          postTypes.forEach((postType: any) => {
            const postIndex = aiDict.findIndex(
              (dict: any) => dict.value === postType
            );
            if (postIndex !== -1) {
              result[postIndex][provinceIndex]++;
            }
          });
        }
      });

      // 调整结果数组顺序以匹配 aiDict 的技术职位顺序
      const rearrangedResult = aiDict.map(
        (dict: any, index: any) => result[index]
      );

      // console.log(rearrangedResult);
      this.box1Data.dataList = rearrangedResult;

      await this.initRBox1();
    } catch (error) {
      // 处理错误
      console.error("Error fetching data1:", error);
    }
  }

  initRBox1() {
    // const xAxisData = []; // ['category0', 'category1', 'category2'...] length: 30 [省份数据] 33
    const legendData: any = []; //  ['trend', '2010', '2011', ...] length: 8 [互联网行业的职位类型...] 10 + 1
    // const dataList = []; // [[category0 - category28的2010年的数据: 长度30 ], [] , [] ...] length: 8 - 1 => 10
    legendData.push(
      "trend",
      "后端开发",
      "前端/移动开发",
      "测试",
      "运维/技术支持",
      "人工智能",
      "销售技术支持",
      "数据",
      "技术项目管理",
      "高端技术职位",
      "其他技术职位"
    );
    let option: any = {
      title: {
        text: "岗位数",
        textStyle: {
          align: "left",
          color: "#fff",
          fontSize: 12,
        },
        top: "5%",
        left: "2%",
      },
      tooltip: {
        trigger: "axis",
      },
      // legend: {
      //   data: legendData
      // },
      grid: {
        top: "18%",
        bottom: "24%",
        left: "14%",
      },
      dataZoom: [
        {
          type: "slider",
          start: 0,
          end: 30,
          height: 10,
          bottom: 20,
          textStyle: {
            color: "#fff", //滚动条两边字体样式
          },
        },
        {
          type: "inside",
          start: 0,
          end: 30,
        },
      ],
      xAxis: [
        {
          type: "category",
          data: this.box1Data.xAxisData,
          axisLine: {
            show: true,
            lineStyle: {
              color: "#fff",
              width: 0,
              type: "solid",
            },
          },
          axisTick: {
            show: false,
          },
          axisLabel: {
            show: true, // 是否显示刻度标签，默认显示
            fontSize: 12,
          },
        },
      ],
      yAxis: [
        {
          type: "value",
          minInterval: 1,
          axisLabel: {
            // formatter: function () {
            //   return "";
            // },
          },
          axisTick: {
            show: false,
          },
          axisLine: {
            show: false,
            lineStyle: {
              color: "#fff",
              width: 1,
              type: "solid",
            },
          },
          splitLine: {
            show: false,
          }, // y轴分割线
        },
      ],
      series: [
        ...this.box1Data.dataList.map(function (data: any, index: any) {
          return {
            type: "bar",
            animation: false,
            name: legendData[index + 1],
            itemStyle: {
              opacity: 0.5,
            },
            data: data,
          };
        }),
      ],
    };

    this.myChart = (this as any).$echarts.init(
      document.getElementById("rBox1")
    ); // 图标初始化
    this.myChart.setOption(option); // 渲染页面
    /* ECharts动态效果 */
    window.addEventListener("resize", () => {
      this.myChart.resize();
    });
  }

  async getRBox2Data() {
    let postArr: any = await getPostListByPrams({});
    let postList = postArr.data.data;
    let on: number = 0;
    let off: number = 0;
    if (postList && postList.length > 0) {
      postList.forEach((item: any) => {
        if (item.recruitment_status == 1) {
          off++;
        } else {
          on++;
        }
      });
    }
    await this.initRBox2(on, off);
  }

  initRBox2(on: any, off: any) {
    let option = {
      title: {
        text: "在招岗位",
        top: "5%",
        left: "2%",
        textStyle: {
          align: "left",
          color: "#fff",
          fontSize: 12,
        },
      },
      tooltip: {
        trigger: "item",
        formatter: "{a} : ({d}%)",
      },
      series: [
        {
          name: "目前在招岗位",
          center: ["50%", "50%"],
          radius: ["70%", "70%"],
          clockWise: false,
          hoverAnimation: false,
          type: "pie",
          data: [
            {
              value: on,
              name: "",
              label: {
                normal: {
                  show: true,
                  formatter: "{d} %",
                  textStyle: {
                    fontSize: 28,
                    fontWeight: "bold",
                  },
                  position: "center",
                },
              },
              labelLine: {
                show: false,
              },
              itemStyle: {
                normal: {
                  color: "#5886f0",
                  borderColor: new (
                    this as any
                  ).$echarts.graphic.LinearGradient(0, 0, 0, 1, [
                    {
                      offset: 0,
                      color: "#00a2ff",
                    },
                    {
                      offset: 1,
                      color: "#70ffac",
                    },
                  ]),
                  borderWidth: 25,
                },
                emphasis: {
                  color: "#5886f0",
                  borderColor: new (
                    this as any
                  ).$echarts.graphic.LinearGradient(0, 0, 0, 1, [
                    {
                      offset: 0,
                      color: "#85b6b2",
                    },
                    {
                      offset: 1,
                      color: "#6d4f8d",
                    },
                  ]),
                  borderWidth: 25,
                },
              },
            },
            {
              name: " ",
              value: off,
              itemStyle: {
                normal: {
                  label: {
                    show: false,
                  },
                  labelLine: {
                    show: false,
                  },
                  color: "rgba(0,0,0,0)",
                  borderColor: "rgba(0,0,0,0)",
                  borderWidth: 0,
                },
                emphasis: {
                  color: "rgba(0,0,0,0)",
                  borderColor: "rgba(0,0,0,0)",
                  borderWidth: 0,
                },
              },
            },
          ],
        },
      ],
    };

    let myChart = (this as any).$echarts.init(document.getElementById("rBox2")); // 图标初始化
    myChart.setOption(option); // 渲染页面
    /* ECharts动态效果 */
    window.addEventListener("resize", () => {
      myChart.resize();
    });
  }

  initBox3Box() {
    let rBox3: any = document.querySelector("#rBox3");
    this.rBox3 = {
      width: rBox3.clientWidth,
      height: rBox3.clientHeight,
    };
  }
  async getRBox3Data() {
    await this.initBox3Box();
    let postList: any = await getPostListByPrams({});
    let arr: any = postList.data.data;

    let resArr: any = arr.map((item: any) => item.company_name);
    let resArr1: any = arr.map((item: any) => item.name);
    let passData = resArr.concat(resArr1);
    if (passData.length > 0) {
      (this as any).$refs.wordCloud.setTags(passData);
    }
  }
  created() {}

  mounted() {
    this.getRBox1Data();
    this.getRBox2Data();
    this.getRBox3Data();
  }
}
</script>

<style lang="scss" scoped>
@import "publicStyle";

#rBox1,
#rBox2,
#rBox3 {
  width: 100%;
  height: 100%;
}
</style>
