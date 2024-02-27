<template>
  <div class="main-view">
    <div class="main-view-title">
      <em> {{ $store.state.loginModule.userInfo.username }} </em>
      欢迎使用招聘信息分析及可视化平台
    </div>

    <div class="main-view-content">
      <span
        class="title"
        @click="$router.push('/dataManage/company')"
        title="点击进入公司管理"
      >
        公司：
      </span>
      <span>
        <countTo
          :startVal="0"
          :endVal="companyTotal"
          :duration="1000"
        ></countTo>
      </span>
      <div class="box">
        <el-tag
          v-for="item in companyList"
          :key="item.id"
          :type="
            ['0', '1'].includes(item.business_status) ? 'success' : 'danger'
          "
        >
          {{ item.name }}
        </el-tag>
      </div>
    </div>

    <div class="main-view-content">
      <span
        class="title"
        @click="$router.push('/dataManage/post')"
        title="点击进入岗位管理"
      >
        岗位：
      </span>
      <span>
        <countTo :startVal="0" :endVal="postTotal" :duration="1000"></countTo>
      </span>
      <div class="box">
        <el-tag
          v-for="item in postList"
          :key="item.id"
          :type="['0'].includes(item.recruitment_status) ? 'success' : 'danger'"
        >
          {{ item.name }}
        </el-tag>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import { getCompanyListByPrams } from "@/api/companyModule";
import { getPostListByPrams } from "@/api/postModule";
import flattenDeep from "@/utils/flattenDeep";
// @ts-ignore
import countTo from "vue-count-to";

@Component({
  components: { countTo },
})
export default class Index extends Vue {
  companyList: any = [];
  postList: any = [];
  companyTotal: any = 0;
  postTotal: any = 0;

  getCompanyList() {
    let userInfo = JSON.parse((localStorage as any).getItem("userInfo"));
    getCompanyListByPrams({
      user_id: userInfo.roleid == 2 ? userInfo.id : null, // 1:管理员 2:普通用户
    })
      .then((res: any) => {
        this.companyList = res.data.data;
        this.companyTotal = res.data.data.length || 0;
      })
      .finally(() => {
        this.getPostList(this.companyList.map((item: any) => item.id));
      });
  }

  getPostList(helpCompanyArr: any) {
    var userInfo = JSON.parse((localStorage as any).getItem("userInfo"));
    var helpTableData: any = [];
    if (userInfo.roleid == 1) {
      /* 管理员 */
      getPostListByPrams({
        company_id: null, // 1:管理员 2:普通用户
      }).then((res: any) => {
        if (res.status === 200) {
          this.postList = res.data.data;
          this.postTotal = res.data.data.length || 0;
        }
      });
    } else if (userInfo.roleid == 2) {
      this.postTotal = 0;
      var companyArr: any = JSON.parse(
        (localStorage as any).getItem("companyArr")
      );
      if (!companyArr && !Array.isArray(companyArr)) {
        companyArr = helpCompanyArr;
      }

      /* 用户 */
      if (companyArr.length > 0) {
        companyArr.forEach((item: any, index: any) => {
          getPostListByPrams({
            company_id: item, // 1:管理员 2:普通用户
          })
            .then((res: any) => {
              if (res.status === 200) {
                helpTableData[index] = res.data.data;
              }
            })
            .finally(() => {
              this.postList = flattenDeep(helpTableData);
              this.postTotal = this.postList.length;
            });
        });
      }
    }
  }

  created() {
    this.getCompanyList();
  }
}
</script>

<style lang="scss" scoped>
.main-view {
  &-title {
    height: 40px;
    font-size: 24px;
    font-weight: bolder;
    letter-spacing: 2px;
    padding: 20px;
    display: flex;
    align-items: center;

    em {
      margin-right: 10px;
    }
  }

  &-content {
    max-height: 300px;
    overflow-y: auto;
    padding: 20px;

    .title {
      font-size: 18px;
      font-weight: bolder;
      font-family: "Microsoft YaHei";

      &:hover {
        cursor: pointer;
        color: #128f8e;
      }
    }

    .box {
      margin-top: 10px;
      display: flex;
      flex-wrap: wrap;

      .el-tag {
        margin: 5px 20px 5px 0;
      }
    }
  }
}
</style>
