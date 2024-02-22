<template>
  <div class="main-view">
    <div id="box1"></div>
    <div id="box2"></div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import * as echarts from "echarts";
import { getDefiniteListByName } from "@/api/definiteModule";
import { getUserByUserName } from "@/api/userModule";
import { getClockCardList } from "@/api/clockCardModule";
import { getHospitalListByHName } from "@/api/hospitalModule";

@Component({
  components: {},
})
export default class TsComp extends Vue {
  getBox1() {
    const box1: any = document.getElementById("box1");
    const chartRisk = echarts.init(box1);
    const option: any = {
      title: {
        text: "统计",
        subtext: "确诊人、密接人、已治愈、已死亡、治疗中",
      },
      xAxis: {
        type: "category",
        // data: ['确诊人(人)', '注册用户(人)', '打卡(天)']
        data: [
          "确诊人(人)",
          "密接人（人）",
          "已治愈(人)",
          "已死亡(人)",
          "治疗中(人)",
        ],
      },
      yAxis: {
        type: "value",
      },
      tooltip: {
        trigger: "axis",
        axisPointer: {
          type: "shadow",
        },
      },
      series: [
        {
          data: [
            {
              value: this.definiteNum,
              itemStyle: {
                color: "lightpink",
              },
            },
            {
              value: this.staticNum,
              itemStyle: {
                color: "rgb(253,198,206)",
              },
            },
            {
              value: this.healthNum,
              itemStyle: {
                color: "lightgreen",
              },
            },
            {
              value: this.dieNum,
              itemStyle: {
                color: "lightcoral",
              },
            },
            {
              value: this.inHospital,
              itemStyle: {
                color: "lightgray",
              },
            },
            // {
            //     value: this.userNum,
            //     itemStyle: {
            //         color: '#fac858'
            //     }
            // },
            // {
            //     value: this.clockCardNum,
            //     itemStyle: {
            //         color: 'lightgreen'
            //     }
            // },
          ],
          type: "bar",
          itemStyle: {
            normal: {
              barBorderRadius: [6, 6, 0, 0], // 设置柱子圆角
            },
          },
          // label: {
          //     normal: {
          //         show: true,
          //         position: 'top',
          //         distance: 5, // 数值离柱子上方的距离
          //         fontSize: 16
          //     },
          // },
        },
      ],
    };
    chartRisk.clear();
    chartRisk.setOption(option);
    // 自适应窗口大小
    window.addEventListener("resize", function () {
      chartRisk.resize();
    });
  }

  getBox2() {
    const box2: any = document.getElementById("box2");
    const chartRisk = echarts.init(box2);
    const option: any = {
      title: {
        text: "疫苗数",
      },
      tooltip: {
        trigger: "axis",
      },
      xAxis: {
        type: "category",
        data: ["第一针", "第二针", "第三针"],
      },
      yAxis: {
        type: "value",
      },
      series: [
        {
          data: [this.firstNum, this.secondNum, this.thirdNum],
          type: "line",
          color: "#4c64fe",
        },
      ],
    };
    chartRisk.clear();
    chartRisk.setOption(option);
    // 自适应窗口大小
    window.addEventListener("resize", function () {
      chartRisk.resize();
    });
  }

  /**
   * 获取确诊人数
   * */
  definiteNum: any = ""; // 确诊人数
  staticNum: any = ""; // 密接人数
  healthNum: any = ""; // 已治愈人数
  dieNum: any = ""; // 已死亡人数
  inHospital: any = ""; // 治疗中人数
  getDefiniteListByName() {
    let definiteNum = 0; // 确诊人数
    let staticNum = 0; // 密接人数
    let nameHealthNum = 0; // 确诊人已治愈人数
    let nameInHospitalNum = 0; // 确诊人治疗中人数
    let nameDieNum = 0; // 确诊人已死亡人数

    let staticHealthNum = 0; // 密接人已治愈人数
    let staticInHospitalNum = 0; // 密接人治疗中人数
    let staticDieNum = 0; // 密接人已死亡人数
    getDefiniteListByName({
      name: "",
      staticname: "",
    }).then((res: any) => {
      if (res.data.data) {
        this.definiteNum = res.data.data.length;
        this.staticNum = res.data.data.length;
        res.data.data.forEach((item: any, index: any) => {
          if (item.name) definiteNum++;
          if (item.staticname) staticNum++;
          if (item.namestatus === "已治愈") nameHealthNum++;
          if (item.namestatus === "治疗中") nameInHospitalNum++;
          if (item.namestatus === "已死亡") nameDieNum++;

          if (item.staticstatus === "已治愈") staticHealthNum++;
          if (item.staticstatus === "治疗中") staticInHospitalNum++;
          if (item.staticstatus === "已死亡") staticDieNum++;
        });
        this.healthNum = nameHealthNum + staticHealthNum;
        this.dieNum = nameDieNum + staticDieNum;
        this.inHospital = nameInHospitalNum + staticInHospitalNum;
        this.definiteNum = definiteNum;
        this.staticNum = staticNum;
        // console.log(definiteNum, staticNum)
        // console.log(nameHealthNum, staticHealthNum, nameDieNum, staticDieNum)
      }
    });
  }

  /**
   * 获取注册用户数
   * */
  userNum: any = ""; // 注册用户数

  getUserByUserName() {
    getUserByUserName({
      username: "",
      role: "",
    }).then((res: any) => {
      if (res.data.data) {
        this.userNum = res.data.data.length;
      }
    });
  }

  /**
   * 获取总打卡天数
   * */
  clockCardNum: any = ""; // 总打卡天数

  getClockCardList() {
    getClockCardList({
      username: "",
      role: "",
    }).then((res: any) => {
      if (res.data.data) {
        this.clockCardNum = res.data.data.length;
      }
    });
  }

  /**
   * 获取疫苗数
   * */
  firstNum: any = 0;
  secondNum: any = 0;
  thirdNum: any = 0;

  getHospitalListByHName() {
    getHospitalListByHName({
      hname: "",
    }).then((res: any) => {
      if (res.data.data) {
        console.log(res.data.data);
        res.data.data.map((item: any, index: any) => {
          this.firstNum += parseInt(item.firstnum);
          this.secondNum += parseInt(item.secondnum);
          this.thirdNum += parseInt(item.thirdnum);
        });
      }
    });
  }

  mounted() {
    this.getDefiniteListByName();
    this.getUserByUserName();
    this.getClockCardList();
    this.getHospitalListByHName();
    setTimeout(() => {
      this.getBox1();
      this.getBox2();
    }, 500);
  }
}
</script>

<style lang="scss" scoped>
#box1 {
  float: left;
  width: 46%;
  margin: 20px;
  height: 700px;
}

#box2 {
  float: right;
  width: 46%;
  margin: 20px;
  height: 700px;
}
</style>
