<template>
  <div class="boxContent">
    <div class="boxContent-public-title">公司分布情况</div>
    <div class="boxContent-public-main">
      <vue-seamless-scroll :data="companyList" class="warp">
        <ul class="item">
          <li
            v-for="(item, index) in companyList"
            :key="index"
            @click.stop="chooseCompany(item)"
          >
            <div class="item-left">
              <span class="item-left-title">{{ item.name }}</span>
              <em class="">（{{ item.address }}）</em>
            </div>

            <div class="item-right">
              {{ item.intro }}
            </div>
          </li>
        </ul>
      </vue-seamless-scroll>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import { getCompanyListByPrams } from "@/api/companyModule";
// @ts-ignore
import vueSeamlessScroll from "vue-seamless-scroll";

@Component({
  components: { vueSeamlessScroll },
})
export default class bottomComp extends Vue {
  companyList: any = []; // 公司列表

  getCompanyList() {
    getCompanyListByPrams({}).then((res: any) => {
      this.companyList = res.data.data;
    });
  }

  chooseCompany(item: any) {
    (this.$parent as any).showCompanyDialog(item);
  }

  mounted() {
    this.getCompanyList();
  }
}
</script>

<style lang="scss" scoped>
@import "publicStyle";

.boxContent-public-title {
  background: url("/public/img/dataScreen/bottomTitle.png");
  background-repeat: no-repeat;
  background-size: 100% 100%;
}

.boxContent-public-main {
  width: calc(100% - 10px * 2);
  height: calc(100% - 40px * 2);
  padding: 20px 10px;

  .warp {
    height: 100%;
    overflow: hidden;

    ul {
      list-style: none;
      padding: 0;
      margin: 0 auto;

      li {
        padding: 0 10px;
        height: 30px;
        line-height: 30px;
        display: flex;
        justify-content: space-between;
        font-size: 15px;
        color: #fff;
        cursor: pointer;

        .item {
          &-left {
            width: 40%;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;

            &-title {
              color: #39ccf5;
            }
          }

          &-right {
            width: 56%;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            text-align: right;
          }
        }

        &:hover {
          border: 1px solid #39ccf5;
          box-sizing: border-box;
        }
      }
    }
  }
}
</style>
