export default {
  namespaced: true,
  state: {
    userInfo: {},
    companyArr: [], // 当前登录人名下的公司id ["12312312", "789898"]
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
    SET_COMPANY_ARR(state: any) {
      let companyArr: any = localStorage.getItem("companyArr");
      state.companyArr = JSON.parse(companyArr);
    },
  },
  actions: {
    getUserInfo(context: any) {
      context.commit("getUserInfo");
    },
    getRemPsdFlag(context: any, flag: boolean) {
      context.commit("getRemPsdFlag", flag);
    },
    getCompanyArr(context: any) {
      context.commit("SET_COMPANY_ARR");
    },
  },
  modules: {},
};
