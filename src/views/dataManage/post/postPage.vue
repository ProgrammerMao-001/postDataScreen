<template>
  <div class="content">
    <!-- 头部 -->
    <div class="main-view-header">
      <div class="main-view-header-left" @click="goBack">
        <i class="el-icon-back"></i>
      </div>
      <div class="main-view-header-right">
        <i class="el-icon-user"></i>
        <span> {{ willPassData.type | getTitle }} </span>
      </div>
    </div>

    <div class="content-main">
      <!-- 岗位信息 -->
      <div class="main-view-content">
        <div class="main-view-content-header">岗位信息</div>
      </div>

      <div class="main-view-main">
        <el-form
          :model="formData"
          :rules="formRules"
          ref="form"
          label-width="150px"
          class=""
        >
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item label="岗位名称：" prop="username">
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.username"
                  size="small"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <!--              todo 修改字典数据-->
              <el-form-item label="职位类型：" prop="username">
                <el-select
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.username"
                  placeholder=""
                  size="small"
                  clearable
                  filterable
                >
                  <el-option
                    v-for="item in businessStatusList"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="招聘状态：" prop="username">
                <el-select
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.userName"
                  placeholder=""
                  size="small"
                  clearable
                  filterable
                >
                  <el-option
                    v-for="item in recruitStatusList"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="学历：" prop="username">
                <el-select
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.username"
                  placeholder=""
                  size="small"
                  clearable
                  filterable
                >
                  <el-option
                    v-for="item in educationList"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="工作年限：" prop="username">
                <el-select
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.userName"
                  placeholder=""
                  size="small"
                  clearable
                  filterable
                >
                  <el-option
                    v-for="item in workExperienceList"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <!--   todo 自动计算平均薪资           -->
              <el-form-item label="薪资范围：" prop="username">
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.username"
                  size="small"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="24">
              <el-form-item label="职位描述：" prop="username">
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.username"
                  type="textarea"
                />
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </div>

      <!-- 公司信息 -->
      <div class="main-view-content">
        <div class="main-view-content-header">公司信息</div>
      </div>

      <div class="main-view-main">
        <el-form :model="formData" ref="form" label-width="150px" class="">
          <el-row>
            <el-col :span="12">
              <el-form-item label="企业名称：" prop="username">
                <el-select
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.userName"
                  placeholder=""
                  size="small"
                  clearable
                  filterable
                >
                  <el-option
                    v-for="item in companyList"
                    :key="item.id"
                    :label="item.username"
                    :value="item.id"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>

            <el-col :span="24">
              <el-form-item label="工作地址：" prop="address">
                {{ formData.username }}
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </div>
    </div>

    <!-- 底部按钮 -->
    <div class="main-view-btn" v-if="willPassData.type !== '详情'">
      <el-button size="small" icon="el-icon-back" @click="goBack"
        >返回
      </el-button>
      <el-button
        type="primary"
        size="small"
        icon="el-icon-check"
        @click="saveUserInfo"
        >保存
      </el-button>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import { register, updateUser, getUserByUserName } from "@/api/userModule";
// import { getCompanyList } from "@/api/companyModule"
@Component({
  components: {},
  filters: {
    getTitle(value: string): string {
      if (value === "详情") {
        return "岗位" + value;
      } else {
        return value + "岗位";
      }
    },
  },
})
export default class PublicPage extends Vue {
  @Prop() willPassData: any;
  formData: any = {
    username: "",
    password: "",
    role: "", // 非必填，不填默认为 用户
    roleid: "", // 非必填，不填默认为 用户 id(2)
  };
  formRules: any = {};
  provinceList: any = []; // 省份列表
  businessStatusList: any = []; // 经营状态列表
  userList: any = []; // 用户列表

  recruitStatusList: any = []; // 招聘状态列表
  educationList: any = []; // 学历列表
  workExperienceList: any = []; // 工作经验列表
  companyList: any = []; // 企业列表

  /**
   * @desc 返回主页
   */
  goBack() {
    (this.$parent as any).backIndex();
  }

  getMapDialogPoint(obj: any) {
    this.$set(this.formData, "point", JSON.stringify(obj.point));
    this.$set(this.formData, "address", obj.address);
  }

  /**
   * @desc 点击 保存 按钮
   */
  saveUserInfo() {
    (this.$refs.form as any).validate((valid: any) => {
      if (valid) {
        if (this.willPassData.type === "新增用户") {
          setTimeout(() => {
            // this.addUser();
          }, 100);
        }
        if (this.willPassData.type === "编辑用户") {
          setTimeout(() => {
            // this.editUser();
          }, 100);
        }
      } else {
        return false;
      }
    });
  }

  /**
   * 新增用户
   */
  addUser() {
    register({
      username: this.formData.username,
      password: this.formData.password,
      role: this.formData.role ? this.formData.role : "用户",
      roleid: this.formData.roleid ? this.formData.roleid : "2",
    })
      .then((res: any) => {
        if (res.status === 200) {
          this.$message.success("新增成功！");
          this.goBack();
          (this.$parent as any).getTableData();
        } else {
          this.$message.warning(res.message);
        }
      })
      .catch((e: any) => {
        throw e;
      });
  }

  /**
   * 编辑用户
   */
  editUser() {
    updateUser({
      id: this.willPassData.data.id,
      username: this.formData.username,
      password: this.formData.password,
      token: this.formData.token,
      role: this.formData.role ? this.formData.role : "用户", // 如果没有选择用户类型则默认为普通用户
      roleid: this.formData.roleid ? this.formData.roleid : "2",
    })
      .then((res: any) => {
        console.log("res", res);
        if (res.status === 200) {
          this.$message.success("新增成功！");
          this.goBack();
          (this.$parent as any).getTableData();
        } else {
          this.$message.warning(res.message);
        }
      })
      .catch((e: any) => {
        throw e;
      });
  }

  /**
   * @desc 获取详情的接口
   */
  getDetail() {
    // getUserDetail({
    //   id: this.willPassData.data.id,
    // }).then((res: any) => {
    //   if (res.data.status === 200) {
    //     console.log(res.data.data);
    //     this.formData = res.data.data[0];
    //   }
    // });
  }

  /**
   * @desc 账号类型 input框点击 出现弹窗
   */
  showMapDialog() {
    console.log(this.formData.position, "点位");
    let passData = {
      type: "选择位置",
      data: this.formData.point ? JSON.parse(this.formData.point) : {},
    };
    (this as any).$refs.mapDialog.showDialog(passData);
  }

  getProvinceList() {
    (this as any).getDict("province").then((res: any) => {
      let arr = res.data.data[0]?.data || "[]";
      this.provinceList = JSON.parse(arr);
    });
  }

  getBusinessStatusList() {
    (this as any).getDict("businessStatus").then((res: any) => {
      let arr = res.data.data[0]?.data || "[]";
      this.businessStatusList = JSON.parse(arr);
    });
  }

  getUserList() {
    getUserByUserName({ role: "" }).then((res: any) => {
      this.userList = res.data.data || [];
    });
  }

  /* 获取企业列表 */
  getCompanyList() {
    // getCompanyList({ role: "" }).then((res: any) => {
    //   this.companyList = res.data.data || [];
    // });
  }

  /* 获取招聘状态列表 */
  getRecruitStatusList() {
    (this as any).getDict("recruitmentStatus").then((res: any) => {
      let arr = res.data.data[0]?.data || "[]";
      this.recruitStatusList = JSON.parse(arr);
    });
  }

  /* 获取学历列表 */
  getEducationList() {
    (this as any).getDict("education").then((res: any) => {
      let arr = res.data.data[0]?.data || "[]";
      this.educationList = JSON.parse(arr);
    });
  }

  /* 获取工作经验列表 */
  getWorkExperienceList() {
    (this as any).getDict("workExperience").then((res: any) => {
      let arr = res.data.data[0]?.data || "[]";
      this.workExperienceList = JSON.parse(arr);
    });
  }

  created() {
    if (this.willPassData.type !== "新增用户") {
      this.getDetail();
    }
    console.log(this.willPassData);
  }

  mounted() {
    this.getUserList();
    this.getProvinceList();
    this.getBusinessStatusList();

    this.getCompanyList();
    this.getRecruitStatusList();
    this.getEducationList();
    this.getWorkExperienceList();
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/styles/colorMap";

.content {
  max-height: calc(80vh - 20px);

  &-main {
    height: calc(80vh - 80px);
    overflow-y: auto;
  }
}

.main-view {
  max-height: 80vh;

  &-header {
    width: 100%;
    height: 50px;
    border-bottom: 1px solid #eee;
    display: flex;
    align-items: center;
    font-size: 15px;
    font-weight: 600;
    color: #666;

    &-left {
      width: 40px;
      height: 24px;
      text-align: center;
      border-right: 1px solid #eee;
      margin: 0 4px;
      cursor: pointer;

      .el-icon-back {
        color: $greenBg;
      }
    }

    &-right {
      .el-icon-user {
        color: $greenBg;
        margin: 0 6px;
      }
    }
  }

  &-content {
    &-header {
      height: 20px;
      margin: 11px 20px 24px;
      padding-bottom: 10px;
      border-bottom: 1px solid #eee;
      color: $greenBg;
      font-style: italic;
    }
  }

  &-main {
    width: 94%;
    margin: 0 auto;
  }

  &-btn {
    width: 94%;
    margin: auto;
    position: absolute;
    bottom: 30px;
    left: 0;
    right: 0;
    display: flex;
    justify-items: right;
    justify-content: flex-end;
  }
}
</style>

<style lang="scss" scoped>
.el-form-item__content .el-input-group {
  vertical-align: baseline !important;
}

.el-input-group__append button.el-button {
  color: #409eff;
}

.el-input--small,
.el-select {
  width: 100%;
}
</style>
