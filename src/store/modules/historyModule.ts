const SET_TABSVIEW = "SET_TABSVIEW";
const DEL_TABSVIEW = "DEL_TABSVIEW";
const RESET_TABSVIEW = "RESET-TABSVIEW";
const OTHER_TABSVIEW = "OTHER_TABSVIEW"; // 关闭其他（即保留 首页 和 当前点击页 的tab）
export default {
  state: {
    visitedTabsView: [
      {
        name: "首页",
        path: "/home",
      },
    ], // 保证每次刷新都能有最原始的一个首页的标签
  },
  mutations: {
    [SET_TABSVIEW](state: any, view: any) {
      if (state.visitedTabsView.find((n: any) => n.path === view.path)) {
        return;
      }
      state.visitedTabsView.push({ name: view.meta.title, path: view.path });
    },
    [DEL_TABSVIEW](state: any, view: any) {
      state.visitedTabsView.forEach((item: any, index: any) => {
        if (item.name === view.name && item.path === view.path)
          state.visitedTabsView.splice(index, 1);
      });
    },
    [RESET_TABSVIEW](state: any) {
      state.visitedTabsView = [
        {
          name: "首页",
          path: "/home",
        },
      ];
    },
    [OTHER_TABSVIEW](state: any, view: any) {
      state.visitedTabsView = view;
    },
  },
  actions: {
    // 添加一个新的tabsView
    addVisitedTabsView({ commit }: any, view: any) {
      commit(SET_TABSVIEW, view);
    },
    // 关闭一个tabsView
    delVisitedTabsView({ commit, state }: any, view: any) {
      return new Promise((resolve, reject) => {
        commit(DEL_TABSVIEW, view);
        resolve([...state.visitedTabsView]);
      });
    },
    // 重置tabsView
    resetTabsView({ commit }: any) {
      commit(RESET_TABSVIEW);
    },
    // 页面中 关闭其他标签的事件
    otherTabsView({ commit }: any, view: any) {
      commit(OTHER_TABSVIEW, view);
    },
  },
  getters: {
    visitedTabsView: (state: any) => state.visitedTabsView,
  },
};
