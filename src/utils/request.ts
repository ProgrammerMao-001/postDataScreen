/**axios封装
 * 请求拦截、相应拦截、错误统一处理
 */
import axios from "axios";
import QS from "qs";
import store from "../store";

// 环境的切换
if (process.env.NODE_ENV == "development") {
  // 本地开发环境
  axios.defaults.baseURL = "http://127.0.0.1:3002/";
} else if (process.env.NODE_ENV == "debug") {
  // 本地测试环境
  axios.defaults.baseURL = "";
} else if (process.env.NODE_ENV == "production") {
  // todo will fix 线上环境
  axios.defaults.baseURL = "";
}

// 请求超时时间
axios.defaults.timeout = 10000;

// post请求头
axios.defaults.headers.post["Content-Type"] =
  "application/x-www-form-urlencoded;charset=UTF-8";

// 请求拦截器
axios.interceptors.request.use(
  (config: any) => {
    // 如果不是外部接口、登陆、注册、验证码的接口
    if (
      config.url === "https://tianqiapi.com/free/day" ||
      config.url === "api/login" ||
      config.url === "api/getPicCode" ||
      config.url === "api/register"
    ) {
      return config;
    } else {
      // 每次发送请求之前判断是否存在token，如果存在，则统一在http请求的header都加上token，不用每次请求都手动添加了
      // 即使本地存在token，也有可能token是过期的，所以在响应拦截器中要对返回状态进行判断
      // if (localStorage.getItem('Authorization')) {
      //     config.headers.Authorization = localStorage.getItem('Authorization');
      // }

      store.dispatch("loginModule/getUserInfo");
      const token = (store as any).state.loginModule.userInfo.token;
      token && (config.headers.Authorization = token);
      return config;
    }
  },
  (error) => {
    return error;
  }
);

// 响应拦截器
axios.interceptors.response.use(
  (response) => {
    if (response.status === 200) {
      return Promise.resolve(response);
    } else {
      return Promise.reject(response);
    }
  },
  // todo will fix 服务器状态码不是200的情况
  (error) => {
    if (error) throw error;
    // if (error.response.status) {
    //     switch (error.response.status) {
    //         // 401: 未登录
    //         // 未登录则跳转登录页面，并携带当前页面的路径
    //         // 在登录成功后返回当前页面，这一步需要在登录页操作。
    //         case 401:
    //             (this as any).$router.replace({
    //                 path: '/login',
    //                 query: {redirect: (this as any).$router.currentRoute.fullPath}
    //             });
    //             break;
    //         // 403 token过期
    //         // 登录过期对用户进行提示
    //         // 清除本地token和清空vuex中token对象
    //         // 跳转登录页面
    //         case 403:
    //             (this as any).$message.warning('登录过期，请重新登录')
    //             // 清除token
    //             localStorage.removeItem('token');
    //             store.commit('loginSuccess', null);
    //             // 跳转登录页面，并将要浏览的页面fullPath传过去，登录成功后跳转需要访问的页面
    //             setTimeout(() => {
    //                 (this as any).$router.replace({
    //                     path: '/login',
    //                     query: {
    //                         redirect: (this as any).$router.currentRoute.fullPath
    //                     }
    //                 });
    //             }, 1000);
    //             break;
    //         // 404请求不存在
    //         case 404:
    //             (this as any).$message.warning('网络请求不存在')
    //             break;
    //         // 其他错误，直接抛出错误提示
    //         default:
    //             (this as any).$message.warning(error.response.data.message)
    //     }
    //     return Promise.reject(error.response);
    // }
  }
);

/**
 * get方法，对应get请求
 * @param {String} url [请求的url地址]
 * @param {Object} params [请求时携带的参数]
 */
export function get(url: any, params: any) {
  return new Promise((resolve, reject) => {
    axios
      .get(url, {
        params: params,
      })
      .then((res) => {
        resolve(res);
      })
      .catch((err) => {
        reject(err);
      });
  });
}

/**
 * post方法，对应post请求
 * @param {String} url [请求的url地址]
 * @param {Object} params [请求时携带的参数]
 */
export function post(url: any, params: any) {
  return new Promise((resolve, reject) => {
    axios
      .post(url, QS.stringify(params))
      .then((res) => {
        resolve(res.data);
      })
      .catch((err) => {
        reject(err.data);
      });
  });
}
