/* 字典模块数据 */
import { getStatus } from "@/api/statusModule";

export default {
  namespaced: true,
  state: {
    statusList: [],
  },
  getters: {},
  mutations: {
    /**
     * @Event 方法
     * @description: 获取状态数据（治愈状态）
     * */
    GET_STATUSLIST(state: any, statusList: any) {
      state.statusList = statusList;
    },
  },
  actions: {
    getStatusList({ commit }: any, statusList: any) {
      getStatus().then((res: any) => {
        if (res.status === 200) {
          commit("GET_STATUSLIST", res.data.data);
        }
      });
    },
  },
  modules: {},
};
