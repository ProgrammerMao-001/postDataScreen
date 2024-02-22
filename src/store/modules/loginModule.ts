export default {
  namespaced: true,
  state: {
    userInfo: {},
    remPsdFlag: true, // 是否记住密码的标记
  },
  getters: {},
  mutations: {
    getUserInfo(state: any) {
      let res: any = localStorage.getItem("userInfo");
      state.userInfo = JSON.parse(res);
    },
    getRemPsdFlag(state: any, flag: boolean) {
      state.remPsdFlag = !flag;
      localStorage.setItem("remPsdFlag", state.remPsdFlag);
    },
  },
  actions: {
    getUserInfo(context: any) {
      context.commit("getUserInfo");
    },
    getRemPsdFlag(context: any, flag: boolean) {
      context.commit("getRemPsdFlag", flag);
    },
  },
  modules: {},
};
