<!-- 个人中心 -->
<template>
  <div class="main-view">
    <div>
      <!-- 头部 -->
      <div class="r-content-header">
        <div class="r-content-header-left">
          <i class="el-icon-user"></i>
          <span class="font"> 个人中心 </span>
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
                  disabled
                  v-model="formData.username"
                  size="small"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="24">
              <el-form-item label="密码：" prop="password">
                <el-input
                  :disabled="isDisable"
                  v-model="formData.password"
                  size="small"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="24">
              <el-form-item label="头像：" prop="fileList">
                <auto-upload-comp
                  :fileList="fileList"
                  @on-response="handleRemoveFile"
                  @getFullPath="getFullPath"
                  :limit="1"
                  ref="uploadImg"
                  name="avater"
                />
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </div>

      <!-- 底部按钮 -->
      <div class="main-view-btn">
        <el-button
          v-if="isDisable"
          type="primary"
          size="small"
          icon="el-icon-edit"
          @click="beEdit"
          >编辑
        </el-button>
        <el-button
          v-else
          type="primary"
          size="small"
          icon="el-icon-check"
          @click="saveUserInfo"
          >保存</el-button
        >
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import autoUploadComp from "@/components/autoUploadComp.vue";
import { updateUser, getUserDetail } from "@/api/userModule";

@Component({
  components: { autoUploadComp },
})
export default class PublicPage extends Vue {
  formData: any = {
    username: "",
    role: "", // 非必填，不填默认为 教师
    roleid: "", // 非必填，不填默认为 教师 id(2)
    headimg: "", // 头像
    password: "",
    token: "", // token
  };
  id: any = ""; // 用户id(userInfo.id)
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
      {
        required: true,
        trigger: "blur",
        validator: this.validateFileList,
      },
    ],
    sex: [
      {
        required: true,
        message: "请选择用户性别",
        trigger: "blur",
      },
    ],
  };
  isDisable: boolean = true;
  room: any = ""; // 寝室号
  roomList: any = []; // 寝室列表
  roomObj: any = {
    cannumber: "",
    id: "",
    ids: "",
    nownumber: "",
    prize: "",
    roomnumber: "",
    teachers: "",
    totalnumber: "",
    totalprize: "",
  }; // 编辑寝室传的数据(当前用户所在寝室的信息)

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
   * @desc 检测是否上传头像
   **/
  validateFileList(rule: any, value: any, callback: any) {
    if (this.fileList.length === 0) {
      callback(new Error("请先上传头像"));
    } else {
      callback();
    }
  }

  /**
   * 点击 编辑 按钮
   */
  beEdit() {
    this.isDisable = false;
  }

  /**
   * @desc 点击 保存 按钮
   */
  saveUserInfo() {
    (this.$refs.form as any).validate((valid: any) => {
      if (valid) {
        this.editUser();
        setTimeout(() => {
          // 更新缓存 --- 更新头像
          this.getDetail();
          localStorage.setItem("userInfo", JSON.stringify(this.formData));
        }, 100);
      } else {
        return false;
      }
    });
  }

  /**
   * 编辑用户
   */
  editUser() {
    updateUser({
      id: this.formData.id,
      username: this.formData.username,
      role: this.formData.role ? this.formData.role : "用户", // 如果没有选择用户类型则默认为用户
      roleid: this.formData.roleid ? this.formData.roleid : "2",
      headimg: this.fileList[0].url,
      password: this.formData.password,
      token: this.formData.token,
    })
      .then((res: any) => {
        if (res.status === 200) {
          this.$message.success("编辑成功！");
          this.isDisable = true;
        } else {
          this.$message.warning(res.message);
        }
      })
      .catch((e: any) => {
        throw e;
      });
  }

  /* 以下是图片上传相关的代码 */
  fileList: any = [];

  handleRemoveFile() {
    this.fileList = [];
  }

  getFullPath(data: any) {
    // 子组件传过来的处理过的图片的路径
    console.log(data);
    this.formData.headimg = data.url;
    this.fileList.push(data);
  }

  /* 以上是图片上传相关的代码 */

  /**
   *  用户的详情接口
   **/
  getDetail() {
    getUserDetail({
      id: this.id,
    }).then((res: any) => {
      this.formData = res.data.data[0];
      this.fileList = [
        {
          name: "",
          url: this.formData.headimg,
        },
      ];
    });
  }

  async created() {
    this.id = JSON.parse((localStorage as any).getItem("userInfo")).id;
    await this.getDetail();
  }
}
</script>

<style lang="scss" scoped>
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
        color: #4c64fe;
      }
    }

    &-right {
      .el-icon-chat-line-round {
        color: #4c64fe;
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
      color: #4c64fe;
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

.r-content-header {
  height: 40px;
  border-bottom: 1px solid #eee;
  margin: 0px 18px 0;
  display: flex;
  justify-content: space-between;

  &-left {
    color: #4c64fe;

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
</style>

<style lang="scss" scoped>
.el-input-group {
  width: 39%;
  height: 32px;
}

.el-input--small {
  width: 330px;
}

.el-select {
  width: 330px;
}
</style>
