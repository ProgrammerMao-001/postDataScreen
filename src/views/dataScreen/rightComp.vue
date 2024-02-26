<template>
  <div class="boxContent">
    <div class="boxContent-public">
      <div class="boxContent-public-title">职位需求情况</div>
      <div class="boxContent-public-main">
        <div id="rBox1"></div>
      </div>
    </div>

    <div class="boxContent-public">
      <div class="boxContent-public-title">学历和薪资情况</div>
      <div class="boxContent-public-main">
        <div id="rBox2"></div>
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
export default class rightComp extends Vue {
  option: any = {};
  myChart: any = null;
  educationList: any = []; // 学历列表
  provinceList: any = []; // 省份列表
  postList: any = []; // 岗位列表
  box2Data: any = {
    data: [],
    total: 0,
  };
  box1Data: any = {
    xAxisData: [],
    dataList: [],
  };
  initRBox2() {
    this.option = {
      backgroundColor: "",
      animation: true,
      title: {
        text: this.box2Data.total, // 中间展示的数字
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
          data: this.box2Data.data,
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
      document.getElementById("rBox2")
    ); // 图标初始化
    this.myChart.setOption(this.option); // 渲染页面
    /* ECharts动态效果 */
    window.addEventListener("resize", () => {
      this.myChart.resize();
    });
  }

  /* 获取rBox2数据 (不同学历的岗位数)*/
  async getRBox2Data() {
    try {
      /* 学历列表 */
      const educationResponse = await (this as any).getDict("education");
      let arr = educationResponse.data.data[0].data || "[]";
      this.educationList = JSON.parse(arr);
      /* 岗位列表 */
      const postListResponse: any = await getPostListByPrams({
        name: undefined,
      });
      this.postList = postListResponse.data.data;

      // console.log(this.postList, this.educationList);
      /* 统计 postList 中education 0 -7 的数量 */
      const educationCount = this.postList.reduce((acc: any, curr: any) => {
        const educationLevel = parseInt(curr.education, 10);
        if (educationLevel >= 0 && educationLevel <= 7) {
          acc[educationLevel] = (acc[educationLevel] || 0) + 1;
        }
        return acc;
      }, {});
      // console.log(educationCount, "educationCount") // {3: 1, 4: 2, 6: 1}

      /* 只保留有数据的 */
      // const transformedData = Object.entries(educationCount).map(([key, value]) => {
      //   const mappingItem = this.educationList.find((item: any) => item.value == key);
      //   return {
      //     name: mappingItem.label,
      //     value,
      //   };
      // });

      /* 没有数据的也统计上面 */
      this.educationList.sort(
        (a: any, b: any) => parseInt(a.value, 10) - parseInt(b.value, 10)
      );
      const transformedData = this.educationList.map((mappingItem: any) => {
        const key = mappingItem.value;
        const count = educationCount[key] || 0;
        return {
          name: mappingItem.label,
          value: count,
        };
      });
      this.box2Data.data = transformedData;
      this.box2Data.total = transformedData.reduce(
        (accumulator: any, currentItem: any) => {
          return accumulator + currentItem.value;
        },
        0
      );

      // console.log(this.box2Data, "box2Data");
      await this.initRBox2();
      // console.log(transformedData, "transformedData") [{name: '初中及以下', value: 0}, ...]
    } catch (error) {
      // 处理错误
      console.error("Error fetching data2:", error);
    }
  }

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
        left: "left",
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
  created() {}

  mounted() {
    this.getRBox1Data();
    this.getRBox2Data();
  }
}
</script>

<style lang="scss" scoped>
@import "publicStyle";

#rBox1,
#rBox2 {
  width: 100%;
  height: 100%;
}
</style>
