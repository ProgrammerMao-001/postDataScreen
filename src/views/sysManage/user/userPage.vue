<template>
  <div class="main-view">
    <!-- 头部 -->
    <div class="main-view-header">
      <div class="main-view-header-left" @click="goBack">
        <i class="el-icon-back"></i>
      </div>
      <div class="main-view-header-right">
        <i class="el-icon-user"></i>
        <span> {{ willPassData.type }} </span>
      </div>
    </div>
    <!-- 用户信息 -->
    <div class="main-view-content">
      <div class="main-view-content-header">用户信息</div>
    </div>

    <div class="main-view-main">
      <el-form
        :model="formData"
        :rules="formRules"
        ref="form"
        label-width="100px"
        class=""
      >
        <el-row :gutter="24">
          <el-col :span="24">
            <el-form-item label="用户名：" prop="username">
              <el-input
                :disabled="willPassData.type === '用户详情'"
                v-model="formData.username"
                size="small"
              ></el-input>
            </el-form-item>
          </el-col>

          <el-col :span="24" v-if="willPassData.type === '新增用户'">
            <el-form-item label="密码：" prop="password">
              <el-input
                :disabled="willPassData.type === '用户详情'"
                type="text"
                v-model="formData.password"
                size="small"
                placeholder="默认：a123456"
              ></el-input>
            </el-form-item>
          </el-col>

          <el-col :span="24">
            <el-form-item label="头像：" prop="fileList">
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

    <!-- 用户权限 -->
    <div class="main-view-content">
      <div class="main-view-content-header">用户权限</div>
    </div>

    <div class="main-view-main2">
      <div class="main-view-main2-main">
        <div class="main-view-main2-main-font">账号类型：</div>
        <el-input
          :disabled="willPassData.type === '用户详情'"
          @focus="showRoleDialog(formData.roleid)"
          placeholder="请选择账号类型"
          size="small"
          v-model="formData.role"
        >
          <template slot="append">
            <i class="el-icon-search"></i>
          </template>
        </el-input>
      </div>
    </div>

    <!-- 底部按钮 -->
    <div class="main-view-btn">
      <el-button size="small" icon="el-icon-back" @click="goBack"
        >返回</el-button
      >
      <el-button
        type="primary"
        size="small"
        icon="el-icon-check"
        @click="saveUserInfo"
        >保存</el-button
      >
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
})
export default class PublicPage extends Vue {
  @Prop() willPassData: any;
  formData: any = {
    username: "",
    password: "a123456",
    role: "", // 非必填，不填默认为 用户
    roleid: "", // 非必填，不填默认为 用户 id(2)
  };
  formRules: any = {
    username: [
      {
        required: true,
        validator: this.validateUsername,
        trigger: "blur",
      },
    ],
    password: [
      {
        required: true,
        validator: this.validatePassword,
        trigger: "blur",
      },
    ],
    fileList: [
      // {
      //   required: true,
      //   // message: '请上传图片',
      //   trigger: "blur",
      //   validator: this.validateFileList,
      // },
    ],
  };

  /**
   * @desc 用户名的校验
   * 10个字符 (只能10个中文字符)
   **/
  validateUsername(rule: any, value: any, callback: any) {
    if (value === "") {
      callback(new Error("请输入用户名"));
    } else if (value && /^(?:[\u4e00-\u9fa5·]{2,10})$/.test(value) === false) {
      callback(new Error("请输入正确的中文用户名"));
    }
    callback();
  }

  /**
   * @desc 密码框的校验
   * 只能输入十个字符，英文和数字组成
   **/
  validatePassword(rule: any, value: any, callback: any) {
    if (value === "") {
      callback(new Error("请输入密码"));
    } else if (value && /^(?=.*[a-zA-Z])(?=.*\d).+$/.test(value) == false) {
      callback(new Error("密码必须由英文和数字组成"));
    } else if (value && value.length > 10) {
      callback(new Error("密码的长度不能大于10位"));
    }
    callback();
  }

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
            this.addUser();
          }, 100);
        }
        if (this.willPassData.type === "编辑用户") {
          setTimeout(() => {
            this.editUser();
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
      headimg:
        this.fileList.length > 0
          ? this.fileList[0].url
          : "https://pic.imgdb.cn/item/65de114a9f345e8d035975f7.png", // 设置默认图片
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
          this.$message.success("编辑成功！");
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
  created() {
    if (this.willPassData.type !== "新增用户") this.getDetail();
    console.log(this.willPassData);
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/styles/colorMap";
.main-view {
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

  &-main2 {
    display: flex;

    &-main {
      display: flex;
      width: 90%;
      margin: 0 auto;

      &-font {
        font-size: 14px;
        width: 78px;
        line-height: 30px;
        color: #606266;
      }
    }
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
  width: 330px;
}
</style>
