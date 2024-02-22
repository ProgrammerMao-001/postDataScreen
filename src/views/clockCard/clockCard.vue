<!-- 打卡 -->
<template>
  <div class="main-view">
    <div class="r-content-header">
      <div class="r-content-header-left">
        <i class="el-icon-thumb"></i>
        <span class="font"> 打卡 </span>
        <el-button
          @click="clockCard"
          type="primary"
          size="small"
          style="margin: 0 10px"
        >
          打卡
        </el-button>
      </div>
    </div>

    <div class="clock-card">
      <el-calendar v-model="calendarTime">
        <template slot="dateCell" slot-scope="{ date, data }">
          <p :class="data.isSelected ? 'is-selected' : ''">
            {{ data.day.split("-").slice(1)[1] }}
            {{ data.isSelected ? "✔️" : "" }}
          </p>
          <p class="is-selected" v-if="getDatetime(data.day)">已打卡</p>
        </template>
      </el-calendar>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import { formatDate } from "@/filter/date";
import { getClockCardList, addClockCard } from "@/api/clockCardModule";

@Component({
  components: {},
})
export default class ClockCard extends Vue {
  formData: any = {
    userid: "",
    datetime: "",
  };
  checkedDatetime: any = [];
  calendarTime: any = new Date();
  today: any = null;

  /**
   * 打卡
   * */
  clockCard() {
    console.log(this.formData);
    this.formData.datetime = formatDate(this.calendarTime, "YYYY-MM-DD");
    if (this.formData.datetime !== this.today) {
      this.$message.warning("只能当天打卡！");
      return;
    }
    addClockCard(this.formData).then((res: any) => {
      if (res.status === 200 || res.status === 201) {
        this.$message.success(res.message);
        this.getClockCard();
        setTimeout(() => {
          this.getDatetime(null);
        }, 500);
      } else {
        this.$message.error("打卡失败！！！");
      }
    });
  }

  getDatetime(data: any) {
    let res = "";
    for (let i = 0; i < this.checkedDatetime.length; i++) {
      if (this.checkedDatetime[i].date === data) {
        res = this.checkedDatetime[i].hasRecord;
        break;
      }
    }
    return res;
  }

  /**
   * 获取打卡数据
   * */
  getClockCard() {
    getClockCardList({}).then((res: any) => {
      let helpArr: any = [];
      if (res.data.status === 200) {
        res.data.data.forEach((item: any, index: any) => {
          if (item.userid === this.formData.userid) {
            helpArr.push({
              date: item.datetime,
              hasRecord: true,
            });
          }
        });
        console.log(helpArr);
        this.checkedDatetime = helpArr;
      }
    });
  }

  created() {
    this.getClockCard();
    setTimeout(() => {
      this.getDatetime(null);
    }, 500);
    this.formData.userid = JSON.parse(
      (localStorage as any).getItem("userInfo")
    ).id;
    this.today = formatDate(new Date(), "YYYY-MM-DD");
    console.log(this.today, "today");
  }
}
</script>

<style lang="scss" scoped>
.r-content-header {
  height: 40px;
  border-bottom: 1px solid #eee;
  margin: 0px 18px 0;
  display: flex;
  justify-content: space-between;

  &-left {
    color: #2244ff;

    .font {
      font-size: 15px;
      font-weight: 600;
      color: #666;
      line-height: 40px;
    }
  }

  &-right {
  }
}

.is-selected {
  color: #1989fa;
}

.clock-card {
  width: 90%;
  margin: auto;
}
</style>
