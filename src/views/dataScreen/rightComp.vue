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
  }; // 岗位列表
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
      console.log(this.provinceList)
      console.log(this.postList, "postList1")
    } catch (error) {
      // 处理错误
      console.error("Error fetching data1:", error);
    }
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

#rBox1, #rBox2 {
  width: 100%;
  height: 100%;
}
</style>
