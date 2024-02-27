<template>
  <div class="public-style">
    <el-dialog
      title="用 户 注 册"
      :visible.sync="dialogVisible"
      :close-on-click-modal="false"
      :close-on-press-escape="false"
      v-elDragDialog
      width="450px"
      :before-close="hideDialog"
    >
      <div class="container">
        <el-form
          :model="formData"
          status-icon
          :rules="formRules"
          ref="formData"
          label-width="88px"
        >
          <el-form-item label="用户名:" prop="username">
            <el-input
              v-focus
              size="medium"
              v-model="formData.username"
            ></el-input>
          </el-form-item>

          <el-form-item label="密码:" prop="password">
            <el-input
              size="medium"
              type="password"
              v-model="formData.password"
              autocomplete="off"
            ></el-input>
          </el-form-item>

          <el-form-item label="确认密码:" prop="checkPass">
            <el-input
              size="medium"
              type="password"
              v-model="formData.checkPass"
              autocomplete="off"
              show-password
            ></el-input>
          </el-form-item>

          <div class="container-footer">
            <el-button
              size="small"
              style="margin-right: 10px"
              type="primary"
              @click="submitForm()"
              >注册
            </el-button>
            <el-button size="small" @click="hideDialog()">取消</el-button>
          </div>
        </el-form>
      </div>
    </el-dialog>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import { register } from "@/api/userModule";

@Component({
  components: {},
})
export default class Register extends Vue {
  dialogVisible: any = false;
  formData: any = {
    username: "",
    password: "",
    checkPass: "",
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
    checkPass: [
      {
        required: true,
        validator: this.validatePassword2,
        trigger: "blur",
      },
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
   * @desc 确认密码是否输入一致
   **/
  validatePassword2(rule: any, value: any, callback: any) {
    if (value === "") {
      callback(new Error("请再次输入密码"));
    } else if (value !== this.formData.password) {
      callback(new Error("两次输入密码不一致!"));
    } else {
      callback();
    }
  }

  /**
   * @desc 注册按钮的点击事件
   **/
  submitForm() {
    (this.$refs.formData as any).validate((valid: any) => {
      if (valid) {
        register({
          username: this.formData.username,
          password: this.formData.password,
          role: "用户", // 外部注册时，默认为用户
          roleid: "2", // 外部注册时，默认为用户 id
          headimg: "https://pic.imgdb.cn/item/65dd4c909f345e8d0332c3f1.jpg",
        })
          .then((res: any) => {
            if (res.status === 200) {
              this.$message.success("注册成功，快去登陆叭");
              this.hideDialog();
            } else {
              this.$message.warning(res.message);
            }
          })
          .catch((err: any) => {
            this.$message.error("注册失败，请稍后再试！");
            throw err;
          });
      } else {
        return false;
      }
    });
  }

  /**
   * @desc 打开弹窗的事件
   */
  showDialog() {
    this.dialogVisible = true;
  }

  /**
   * @desc 关闭弹窗的事件
   */
  hideDialog() {
    (this.$refs.formData as any).resetFields();
    this.dialogVisible = false;
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/styles/colorMap";
::v-deep .el-dialog {
  margin-top: 24vh !important;
  min-width: 450px !important;
  height: 330px;
}

::v-deep .el-dialog__title {
  color: $greenBg !important;
}

::v-deep .el-input {
  width: 92%;
}

::v-deep .el-input--medium .el-input__inner {
  border-radius: 8px !important;
}

.container {
  &-footer {
    float: right;
  }
}
</style>
