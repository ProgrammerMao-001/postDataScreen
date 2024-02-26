<!-- todo 判断如果记住密码的情况下 用户名和密码输入框自动填充账号密码-->
<template>
  <div class="login">
    <!-- 头部标题 - 开始 -->
    <div class="head-title">
      <div class="title--h1"></div>
    </div>

    <!-- 头部标题 - 开始 -->

    <!-- 左侧图片模块 - 开始 -->
    <div class="left"></div>
    <!-- 左侧图片模块 - 结束 -->

    <!-- 右侧账号密码登录模块 - 开始 -->
    <div class="right">
      <!-- 登录表单 -->
      <div class="form">
        <!-- 登录头部 -->
        <div class="form_head">用 户 登 录</div>
        <!-- 登录主体内容 -->
        <div class="main">
          <!-- 输入账号 -->
          <div class="main--user">
            <i
              ref="userIcon"
              :class="{
                'icon--chose-color': iconChose === 'username',
                'icon--no-inp--color': userInpFlag.username,
              }"
              class="iconfont icon-user"
            ></i>
            <input
              ref="username"
              v-model.trim="userInfo.username"
              :class="{ 'inp--no-inp--color': userInpFlag.username }"
              @input="setInpColor('username')"
              @keyup="noSpace"
              @focus="changeColor('username', 'username')"
              @blur="changeColor('')"
              type="text"
              placeholder="请输入账号"
            />
          </div>
          <!-- 输入密码 -->
          <div class="main--psd">
            <i
              ref="psdIcon"
              :class="{
                'icon--chose-color': iconChose === 'password',
                'icon--no-inp--color': userInpFlag.password,
              }"
              class="iconfont icon-icon-mima"
              style="font-size: 21px; left: 3px; top: 0"
            ></i>
            <input
              ref="password"
              v-model.trim="userInfo.password"
              :class="{ 'inp--no-inp--color': userInpFlag.password }"
              @input="setInpColor('password')"
              @keyup="noSpace"
              @focus="changeColor('password', 'password')"
              @blur="changeColor('')"
              :type="isShowPwd ? 'text' : 'password'"
              placeholder="请输入密码"
            />
            <div
              @click="showPwd"
              style="position: absolute; right: 30px; top: 6px; cursor: pointer"
            >
              <i
                :class="[
                  isShowPwd
                    ? 'iconfont icon-yanjing'
                    : 'iconfont icon-biyanjing',
                  iconChose === 'password' ? 'icon--chose-color' : '',
                  userInpFlag.password ? 'icon--no-inp--color' : '',
                ]"
              ></i>
            </div>
          </div>
          <!-- 输入验证码 -->
          <div class="main--verifi">
            <i
              ref="verificationCode"
              :class="{
                'icon--chose-color': iconChose === 'verificationCode',
                'icon--no-inp--color': userInpFlag.verificationCode,
              }"
              class="iconfont icon-yanzhengma"
            ></i>
            <input
              ref="verificationCode"
              v-model.trim="userInfo.verificationCode"
              :class="{ 'inp--no-inp--color': userInpFlag.verificationCode }"
              @input="setInpColor('verificationCode')"
              @focus="changeColor('verificationCode', 'verificationCode')"
              @blur="changeColor('')"
              type="text"
              maxLength="4"
              placeholder="验证码"
            />
            <div @click="getValidatorCode" class="main--verifi_code">
              <span v-show="!validatorCodeUrl"> 重新获取 </span>
              <div id="pic-code" v-html="validatorCodeUrl"></div>
            </div>
          </div>
          <!-- 记住密码 -->
          <div class="rem-psd">
            <!-- 未输入表单的提示 -->
            <span v-show="tipsMark" class="rem-psd_span">{{ tips }}</span>
            <!-- 记住密码 -->
            <i
              ref="rememberPsdRef"
              @click="isRememberPsd"
              class="rem-psd_i"
            ></i>
            <span
              v-show="remPsdFlag"
              style="font-size: 20px; line-height: 0px; color: $greenBg"
            >
              √
            </span>
            <div @click="isRememberPsd" class="rem-psd_div">记住密码</div>
          </div>
          <!-- 登录按钮 -->
          <el-button
            @click="handleLogin"
            :loading="isLoading"
            type="primary"
            class="btn--login"
            >登录
          </el-button>
        </div>
        <!-- 登录尾部 -->
        <div class="footer">
          <!-- 上部 -->
          <div class="head">
            <!-- 注册 -->
            <div @click="goRegister" class="head_forgive-psd">
              还没有账号？点此注册！
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="footer-info"></div>
    <registerDialog ref="registerDialog" />
  </div>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import { getPicCode, login } from "@/api/userModule";
import registerDialog from "@/views/loginOrRegister/registerDialog.vue";
import { getCompanyListByPrams } from "@/api/companyModule";

@Component({
  components: { registerDialog },
})
export default class Login extends Vue {
  iconChose = ""; // 被选中的图标
  isLoading = false; // 被选中的图标
  remPsdFlag: any = false; // 是否记住密码
  validatorCodeUrl = ""; // 验证码图片路径
  verificationCodeKey = ""; // 验证码存储的 key
  // 用户输入的账户密码验证码对象
  userInfo: any = {
    username: "", // 账号
    password: "", // 密码
    verificationCode: "", // 四位验证码
  };
  // 用户是否输入了账号密码验证码
  userInpFlag: object = {
    username: false,
    password: false,
    verificationCode: false,
  };
  tipsMark = false; // 错误提示显示
  tips = ""; // 错误提示内容
  isShowPwd = false; // 是否展示密码的标志

  /**
   * @desc Vue 创建数据生命周期，获取验证码
   * @desc 获取缓存内容 判断是否记住密码
   * @param1 暂无
   * @returns 暂无
   */
  created() {
    this.getValidatorCode(); // 获取验证码
    this.getUserInfo();
    // 用户名输入框聚焦
    this.$nextTick(() => {
      (this.$refs.username as any).focus();
    });
  }

  /**
   * @desc 判断缓存中是否有密码
   */
  getUserInfo() {
    let helpUserInfo = JSON.parse((localStorage as any).getItem("userInfo"));
    let helpRemPsdFlag = JSON.parse(
      (localStorage as any).getItem("remPsdFlag")
    );
    // 已经记住密码的情况下刷新页面，自动填充账号和密码
    if (helpUserInfo && helpRemPsdFlag) {
      this.remPsdFlag = true;
      this.userInfo.username = helpUserInfo.username;
      this.userInfo.password = helpUserInfo.password;
    } else {
      // 没有记住密码的情况下刷新页面
      this.remPsdFlag = false;
      this.userInfo = {
        username: "", // 账号
        password: "", // 密码
        verificationCode: "", // 四位验证码
      };
    }
  }

  /**
   * @desc 绑定监听事件
   **/
  mounted() {
    window.addEventListener("keydown", this.keyDown);
  }

  /**
   * @desc 销毁事件
   **/
  destroyed() {
    window.removeEventListener("keydown", this.keyDown, false);
  }

  /**
   * @desc 监听回车键执行事件
   **/
  keyDown(e: any) {
    // 回车则执行登录方法 enter键的ASCII是13
    if (e.keyCode === 13) {
      this.handleLogin();
    }
  }

  /**
   * @desc 当 input 标签被选中或失焦时更改 图标 的颜色。
   * @param1 传入 iconChose 给特定图标上色。
   * @returns 无
   */
  changeColor(iconChose: string, type?: any): void {
    (this.userInpFlag as any)[type] = false;
    this.iconChose = iconChose;
  }

  /**
   * @desc 点击切换是否记住密码
   * @param1 无
   * @returns 无
   */
  isRememberPsd(): void {
    this.$store.dispatch("loginModule/getRemPsdFlag", this.remPsdFlag);
    this.remPsdFlag = !this.remPsdFlag;
  }

  /**
   * @desc 当input 输入时会调用该函数，用于将红色图标和input变为蓝色。
   * @param1 用户的信息参数。
   * @returns 无
   */
  setInpColor(str: string): void {
    this.iconChose = str;
    (this.userInpFlag as any)[str] = false;
  }

  /**
   * @desc 用户登录按钮点击事件，点击登录，先验证是否输入账号密码。
   * @param1   暂无
   * @returns 暂无
   */
  handleLogin(): void {
    let n = true;
    let flag = true;
    // 判断是否填写所有内容
    for (const key in this.userInfo) {
      if ((this.userInfo as any)[key] == "") {
        flag = false;
        if (n) {
          (this.$refs[key] as any).focus();
          n = false;
        }
        (this.userInpFlag as any)[key] = true;
      }
    }

    // 判断验证码是否正确
    if (flag && this.userInfo.verificationCode !== this.verificationCodeKey) {
      (this.userInfo as any).verificationCode = ""; // 清空内容
      (this.$refs.verificationCode as any).focus(); // 聚焦
      (this.userInpFlag as any).verificationCode = true; // 红色提示
      this.tipsMark = true;
      this.tips = "请输入正确验证码";
      this.isLoading = false;
      this.getValidatorCode(); // 刷新验证码
    }
    if (
      flag &&
      flag &&
      this.userInfo.verificationCode === this.verificationCodeKey
    ) {
      this.isLoading = true;
      this.tipsMark = false;
      login({
        username: this.userInfo.username,
        password: this.userInfo.password,
      })
        .then((res: any) => {
          if (res.status === 200) {
            localStorage.setItem("userInfo", JSON.stringify(res.userInfo));
            this.isLoading = false;
            this.$message.success("登陆成功");
            this.$store.dispatch("loginModule/getUserInfo");
            this.getCompanyArr(res); // 获取公司列表
            this.$router.push("/home");
          }
          if (res.status === 101404) {
            (this.$refs.username as any).focus(); // 聚焦
            (this.userInpFlag as any).username = true; // 红色提示
            this.tipsMark = true;
            this.tips = "账号不存在，请重试！";
            this.isLoading = false;
          }
          if (res.status === 101101) {
            (this.$refs.password as any).focus(); // 聚焦
            (this.userInpFlag as any).password = true; // 红色提示
            this.tipsMark = true;
            this.tips = "密码错误，请重试！";
            this.isLoading = false;
          }
        })
        .catch((err: any) => {
          console.log(err);
          this.isLoading = false;
          this.getValidatorCode(); // 刷新验证码
          this.$message.error("登录失败，请重试！");
        });
    }
  }

  /**
   * @desc 限制用户在 input 中输入 空格等非法字符。
   * @param1 传入 事件对象
   * @returns 无
   */
  noSpace(e: any) {
    e.target.value = e.target.value.replace(
      /[`~!#$%^&*()_\+=<>?:"{}|~！#￥%……&*（）={}|《》？：“”【】、；‘’，。、\s+]/g,
      ""
    );
  }

  /**
   * @desc 获取验证码
   * @param1 暂无
   * @returns 暂无
   */
  getValidatorCode(): void {
    this.isLoading = false;
    getPicCode()
      .then((res: any) => {
        this.verificationCodeKey = res.data.str;
        this.validatorCodeUrl = res.data.img;
      })
      .catch((error: any) => {
        this.$message.error("获取验证码失败，请重试！");
      });
  }

  /**
   * @desc 展示/隐藏 密码
   */
  showPwd() {
    this.isShowPwd = !this.isShowPwd;
  }

  /**
   * @desc 跳转到注册页面
   */
  goRegister() {
    (this.$refs.registerDialog as any).showDialog();
  }

  /* 获取企业列表 */
  getCompanyArr(res: any) {
    // console.log(res.userInfo.id, "user_id")
    getCompanyListByPrams({ user_id: res.userInfo.id }).then((res: any) => {
      if (res.data?.data && res.data.data.length > 0) {
        let arr = res.data.data?.map((obj: any) => obj.id);
        localStorage.setItem("companyArr", JSON.stringify(arr));
        this.$store.dispatch("loginModule/getCompanyArr", JSON.stringify(arr));
      } else {
        localStorage.setItem("companyArr", JSON.stringify([]));
        this.$store.dispatch("loginModule/getCompanyArr", JSON.stringify([]));
      }
    });
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/styles/colorMap";
.icon--chose-color {
  color: rgb(96, 98, 102) !important;
}

.rem-psd_i-bg {
  background-color: $greenBg;
}

.icon--no-inp--color {
  color: $red !important;
}

.inp--no-inp--color {
  border-color: $red !important;

  &::placeholder {
    color: $red !important;
  }
}

.login {
  position: relative;
  width: 100%;
  height: 100%;
  min-width: 1280px;
  min-height: 800px;
  overflow: hidden;
  background: $greenBg;
  background-size: cover;
  /* 头部标题logo */
  .head-title {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 80px;
    background-color: $greenOBg;
    align-items: center;
    display: flex;
    padding-left: 20px;

    /* 大标题 */
    .title--h1 {
      float: left;
      width: 533px;
      height: 50px;
      background: url("../../assets/pic/logo.png") no-repeat;
      background-size: auto 50px;
    }
  }

  /* 左侧背景图片 */
  .left {
    width: 47%;
    height: 47%;
    position: absolute;
    left: 5%;
    top: 20%;
    background: url("../../assets/pic/bg.png") no-repeat center;
    background-size: contain;
  }

  /* 右侧登录界面 */
  .right {
    position: absolute;
    right: 8.95%;
    top: 26.83%;
    width: 500px;
    padding-bottom: 16px;
    border-radius: 20px;
    box-shadow: 1px 11px 15px 5px rgba(0, 0, 0, 0.06);
    background: #ffffff;

    .right_qrcode {
      position: absolute;
      top: 8px;
      right: 6px;
      width: 64px;
      height: 64px;
      background-size: contain;
      cursor: pointer;
    }

    /* 用户登录表单 */
    .form {
      width: 72%;
      margin-top: 7.63%;
      margin-left: 15%;
      /* 用户账号密码表单头部 */
      .form_head {
        width: 100%;
        height: 33px;
        line-height: 33px;
        margin-bottom: 54px;
        text-align: center;
        font-size: 24px;
        font-weight: 600;
        letter-spacing: 1px;
        color: $greenBg;
      }

      /* 用户账号密码表单主题 */
      .main {
        .main--user,
        .main--psd,
        .main--verifi {
          position: relative;
          width: 340px;
          height: 40.25px;
          margin-top: 16px;
          margin-left: 11px;

          i {
            position: absolute;
            left: 5px;
            top: 1px;
            width: 19.5px;
            height: 22.25px;
            font-size: 18px;
            color: #969fa9;
          }

          input {
            display: inline-block;
            width: 300px;
            height: 23.25px;
            border: 0;
            border-bottom: 1px solid #ccc;
            outline: medium;
            padding: 0 0 16px 40px;
            color: #666;

            &::placeholder {
              color: #969fa9;
              font-size: 14px;
            }

            &:focus {
              border-bottom-color: rgb(96, 98, 102);
            }
          }

          .main--verifi_code {
            position: absolute;
            right: 3px;
            bottom: 13px;
            width: 90px;
            height: 30px;
            cursor: pointer;
            background-color: #f5f7fa;
            color: #666;
            font-size: 14px;
            line-height: 30px;
            text-align: center;
            letter-spacing: 2px;

            .el-image {
              width: 100%;
              height: 100%;
            }
          }
        }

        /* 记住密码 */
        .rem-psd {
          position: relative;
          width: 76px;
          height: 22px;
          margin-top: 18px;
          margin-left: 10px;
          line-height: 22px;
          color: #969fa9;
          font-size: 14px;
          float: right;

          .rem-psd_span {
            margin-right: 0;
            font-size: 14px;
            color: $red;
            user-select: none;
            position: absolute;
            left: -274px;
          }

          .rem-psd_i {
            position: absolute;
            top: 6px;
            right: 64px;
            width: 9px;
            height: 9px;
            border: 1px solid $greenBg;
            border-radius: 2px;
            cursor: pointer;
          }

          .rem-psd_div {
            float: right;
            display: inline-block;
            cursor: pointer;
            user-select: none;
          }

          &:hover {
            color: $greenBg;
          }
        }

        /* 登录按钮 */
        .btn--login {
          transition: all 0.1s;
          width: 360px;
          height: 45px;
          margin-top: 17px;
          border-radius: 80px;
          background-color: $greenBg;
          text-align: center;
          color: #ffffff;
          font-size: 17px;
          border: none !important;
          cursor: pointer;
          user-select: none;
          letter-spacing: 4px;

          &:hover {
            background-color: $greenBg;
          }
        }
      }

      /* 登录尾部:注册、忘记密码、使用其他账号 */
      .footer {
        width: 100%;
        margin-top: 16px;

        .head {
          position: relative;
          height: 22px;
          line-height: 22px;
          font-size: 14px;
          color: #969fa9;

          .head_reg {
            position: absolute;
            left: 0;
            top: 0;
            cursor: pointer;

            &:hover {
              color: $greenBg;
            }
          }

          .head_forgive-psd {
            position: absolute;
            right: -50px;
            top: 0;
            cursor: pointer;

            &:hover {
              color: $greenBg;
            }
          }
        }

        .main {
          position: relative;
          height: 46px;
          line-height: 46px;
          margin-top: 36px;
          font-size: 13px;
          color: #969fa9;

          .main_msg {
            position: absolute;
            left: 55px;
            top: 0;
          }

          .main_other {
            position: absolute;
            right: 65px;
            top: 0;

            span {
              transition: all 0.1s;
              display: inline-block;
              width: 30px;
              height: 30px;
              margin-left: 8px;
              font-size: 30px;
              cursor: pointer;

              &:hover {
                color: $greenBg;
              }
            }
          }
        }
      }
    }
  }

  /* 底部信息栏 */
  .footer-info {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 50px;
    padding-top: 12px;
    padding-bottom: 4px;
    text-align: center;
    background-color: $greenOBg;
    line-height: 12px;
    color: #ccc;
    font-size: 12px;
  }
}
</style>
