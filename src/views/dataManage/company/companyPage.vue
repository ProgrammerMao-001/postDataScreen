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
      <!-- 公司信息 -->
      <div class="main-view-content">
        <div class="main-view-content-header">公司信息</div>
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
              <el-form-item label="企业名称：" prop="name">
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.name"
                  size="small"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="经营状态：" prop="business_status">
                <el-select
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.business_status"
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
              <el-form-item label="法定代表人：" prop="user_id">
                <el-select
                  v-model="formData.user_id"
                  placeholder=""
                  size="small"
                  filterable
                  :disabled="willPassData.type === '详情'"
                  @change="getUserName"
                >
                  <el-option
                    v-for="item in userList"
                    :key="item.id"
                    :label="item.username"
                    :value="item.id"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="成立时间：" prop="founded">
                <el-date-picker
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.founded"
                  type="date"
                  size="small"
                  placeholder=""
                  value-format="yyyy-MM-dd"
                >
                </el-date-picker>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="统一社会信用代码：" prop="social_code">
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.social_code"
                  size="small"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="登记机关：" prop="registration_authority">
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.registration_authority"
                  size="small"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="24">
              <el-form-item label="公司简介：" prop="intro">
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.intro"
                  type="textarea"
                />
              </el-form-item>
            </el-col>

            <el-col :span="24">
              <el-form-item label="经营范围：" prop="business_scope">
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.business_scope"
                  size="small"
                  type="textarea"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="24">
              <el-form-item label="企业照片：" prop="fileList">
                <auto-upload-comp
                  :fileList="fileList"
                  @on-response="handleRemoveFile"
                  :limit="1"
                  @getFileList="getFileList"
                  @getFullPath="getFullPath"
                  ref="uploadImg"
                  name="avater"
                />
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </div>

      <!-- 公司地址 -->
      <div class="main-view-content">
        <div class="main-view-content-header">公司地址</div>
      </div>

      <div class="main-view-main">
        <el-form :model="formData" ref="form" label-width="150px" class="">
          <el-row>
            <el-col :span="12">
              <el-form-item label="所在省份：" prop="province_id">
                <el-select
                  :disabled="willPassData.type === '详情'"
                  @change="getProvinceName"
                  v-model="formData.province_id"
                  placeholder=""
                  size="small"
                  clearable
                  filterable
                >
                  <el-option
                    v-for="item in provinceList"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value.toString()"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="选择点位：" prop="username">
                <el-input
                  disabled
                  placeholder="地图上选择位置后自动获取经纬度"
                  size="small"
                  v-model="formData.point"
                >
                  <template slot="append">
                    <el-button
                      size="small"
                      icon="el-icon-location"
                      @click="showMapDialog"
                      >选择
                    </el-button>
                  </template>
                </el-input>
              </el-form-item>
            </el-col>

            <el-col :span="24">
              <el-form-item label="详细地址：" prop="address">
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.address"
                  type="textarea"
                />
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
    <mapDialog ref="mapDialog" @getPoint="getMapDialogPoint" />
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import autoUploadComp from "@/components/autoUploadComp.vue";
import mapDialog from "@/components/mapDialog.vue";
import { getUserByUserName } from "@/api/userModule";
import {
  addCompany,
  updateCompany,
  getCompanyDetail,
} from "@/api/companyModule";

@Component({
  components: { autoUploadComp, mapDialog },
  filters: {
    getTitle(value: string): string {
      if (value === "详情") {
        return "公司" + value;
      } else {
        return value + "公司";
      }
    },
  },
})
export default class PublicPage extends Vue {
  @Prop() willPassData: any;
  formData: any = {};
  formRules: any = {
    fileList: [
      {
        required: true,
        // message: '请上传图片',
        trigger: "blur",
        validator: this.validateFileList,
      },
    ],
  };
  provinceList: any = []; // 省份列表
  businessStatusList: any = []; // 经营状态列表
  userList: any = []; // 用户列表

  /**
   * @desc 检测是否上传图片
   **/
  validateFileList(rule: any, value: any, callback: any) {
    if (this.fileList.length === 0) {
      callback(new Error("请先上传图片"));
    } else {
      callback();
    }
  }

  /* 下拉获取法人名称 */
  getUserName(e: any) {
    let res = this.userList.filter((item: any) => {
      return item.id === e;
    })[0];
    this.formData.user_name = res.username;
  }

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
        console.log(this.fileList);
        if (this.willPassData.type === "新增") {
          setTimeout(() => {
            this.addData();
          }, 100);
        }
        if (this.willPassData.type === "编辑") {
          setTimeout(() => {
            this.editData();
          }, 100);
        }
      } else {
        return false;
      }
    });
  }

  /**
   * 新增公司
   */
  addData() {
    addCompany(this.formData)
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
   * 编辑公司
   */
  editData() {
    updateCompany({
      id: this.willPassData.data.id,
      ...this.formData,
    })
      .then((res: any) => {
        console.log("res", res);
        if (res.status === 200) {
          this.$message.success("新增成功！");
          this.goBack();
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
    getCompanyDetail({
      id: this.willPassData.data.id,
    }).then((res: any) => {
      if (res.data.status === 200) {
        console.log(res.data.data);
        this.formData = res.data.data[0];
        this.fileList = [
          {
            name: res.data.data[0].picname,
            url: res.data.data[0].photos,
          },
        ];
      }
    });
  }

  /**
   * @desc 在地图上选择点位
   */
  showMapDialog() {
    console.log(this.formData.position, "点位");
    let passData = {
      type: "选择位置",
      data: this.formData.point ? JSON.parse(this.formData.point) : {},
    };
    (this as any).$refs.mapDialog.showDialog(passData);
  }

  /* 以下是图片上传相关的代码 */
  fileList: any = [];

  handleRemoveFile() {
    this.fileList = [];
  }

  getFileList(data: any) {}

  getFullPath(data: any) {
    this.formData.picurl = data.url;
    this.fileList.push(data);
  }

  /* 以上是图片上传相关的代码 */

  getProvinceList() {
    (this as any).getDict("province").then((res: any) => {
      let arr = res.data.data[0]?.data || "[]";
      this.provinceList = JSON.parse(arr);
    });
  }

  getProvinceName(e: any) {
    let res = this.provinceList.filter((item: any) => {
      return item.id === e;
    })[0];
    this.formData.province = res.label;
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

  created() {
    if (this.willPassData.type !== "新增") {
      this.getDetail();
    }
    console.log(this.willPassData);
  }

  mounted() {
    this.getUserList();
    this.getProvinceList();
    this.getBusinessStatusList();
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
