import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import axios from "axios";
import ElementUI from "element-ui";
import "element-ui/lib/theme-chalk/index.css";
import "@/assets/styles/public.scss";
// 将自动注册所有组件为全局组件
// @ts-ignore
import dataV from "@jiaminghi/data-view";
// 全局自定义指令
import directive from "@/directives";
import getDict from "@/utils/getDict";
Vue.prototype.getDict = getDict;
import filter from "./filter";
Vue.use(filter);
Vue.prototype.$axios = axios;
Vue.use(ElementUI);
Vue.use(dataV);
Vue.use(directive);

Vue.config.productionTip = false;
/**
 * todo 路由发生变化修改页面title
 * 路由守卫
 * 刷新也不失效
 * 必须放在路由挂载前
 * */

router.beforeEach((to: any, from: any, next: any) => {
  if (to.meta.title) {
    document.title = to.meta.title;
  }
  next();
});

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");
