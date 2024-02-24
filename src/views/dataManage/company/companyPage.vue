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
              <el-form-item label="企业名称：" prop="username">
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.username"
                  size="small"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="企业类型：" prop="username">
                <!-- todo 换成下拉 -->
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.username"
                  size="small"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="经营状态：" prop="username">
                <!-- todo 换成下拉 -->
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.username"
                  size="small"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="法定代表人：" prop="username">
                <!-- todo 换成下拉 -->
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.username"
                  size="small"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="成立时间：" prop="username">
                <!-- todo 换成时间选择器 -->
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.username"
                  size="small"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="统一社会信用代码：" prop="username">
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.username"
                  size="small"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="登记机关：" prop="username">
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.username"
                  size="small"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="经营范围：" prop="username">
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.username"
                  size="small"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="24">
              <el-form-item label="公司简介：" prop="username">
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.username"
                  type="textarea"
                />
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
              <el-form-item label="所在省份：" prop="username">
                <el-select v-model="formData.username" placeholder="">
                  <el-option
                    v-for="item in provinceList"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="选择点位：" prop="username">
                <!-- todo 地图上选点 -->
                <el-input
                  :disabled="willPassData.type === '详情'"
                  @focus="showRoleDialog(formData.roleid)"
                  placeholder="地图上选择位置后自动获取经纬度"
                  size="small"
                  v-model="formData.role"
                >
                  <template slot="append">
                    <i class="el-icon-search"></i>
                  </template>
                </el-input>
              </el-form-item>
            </el-col>

            <el-col :span="24">
              <el-form-item label="详细地址：" prop="username">
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
    </div>

    <!-- 底部按钮 -->
    <div class="main-view-btn">
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

    <!-- 选择账号类型的弹窗 -->
    <roleDialog ref="roleDialog" @on-response="getPassData" />
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import { getUserDetail } from "@/api/userModule";
import roleDialog from "@/components/roleDialog.vue";
import autoUploadComp from "@/components/autoUploadComp.vue";
import { register, updateUser } from "@/api/userModule";

@Component({
  components: { autoUploadComp, roleDialog },
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
  formData: any = {
    username: "",
    password: "",
    role: "", // 非必填，不填默认为 用户
    roleid: "", // 非必填，不填默认为 用户 id(2)
  };
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

  /**
   * @desc 返回主页
   */
  goBack() {
    (this.$parent as any).backIndex();
  }

  /**
   * @desc 点击 保存 按钮
   */
  saveUserInfo() {
    (this.$refs.form as any).validate((valid: any) => {
      if (valid) {
        console.log(this.fileList);
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
      headimg: this.fileList[0].url,
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
      headimg: this.fileList[0].url,
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
    getUserDetail({
      id: this.willPassData.data.id,
    }).then((res: any) => {
      if (res.data.status === 200) {
        console.log(res.data.data);
        this.formData = res.data.data[0];
        this.fileList = [
          {
            name: res.data.data[0].picname,
            url: res.data.data[0].headimg,
          },
        ];
      }
    });
  }

  /**
   * @desc 账号类型 input框点击 出现弹窗
   */
  showRoleDialog(data: any) {
    (this.$refs.roleDialog as any).showDialog(data);
  }

  /**
   * @desc 获取 子组件弹窗传来的数据
   */
  getPassData(data: any) {
    this.formData.role = data[0].name;
    this.formData.roleid = data[0].id;
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
      console.log(this.provinceList, "provinceList");
    });
  }
  created() {
    if (this.willPassData.type !== "新增用户") {
      this.getDetail();
    }
    console.log(this.willPassData);
  }

  mounted() {
    this.getProvinceList();
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/styles/colorMap";

.content {
  max-height: calc(80vh - 20px);

  &-main {
    border: 1px solid red;
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
.el-input-group {
  width: 39%;
  height: 32px;
}

.el-input--small {
  width: 100%;
}
</style>
