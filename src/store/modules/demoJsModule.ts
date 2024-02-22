export default {
  namespaced: true,
  state: {
    count: 1,
    arr: [
      { id: 1, text: "test", done: true },
      { id: 2, text: "test2", done: true },
      { id: 3, text: "test3", done: false },
    ],
  },
  getters: {
    doneArr(state: any) {
      return state.arr.filter((arg: any) => arg.doen);
    },
    doneArrLength(state: any) {
      return state.arr.filter((arg: any) => arg.doen).length;
    },
  },
  mutations: {
    modifyArr(state: any, obj: any) {
      state.arr.push(obj);
      console.log(state.arr);
    },

    addCount(state: any) {
      state.count++;
    },
  },
  actions: {
    // todo Action 提交的是 mutation，而不是直接变更状态。
    // todo Action 可以包含任意异步操作。
    addCount(context: any) {
      setTimeout(() => {
        context.commit("addCount");
      }, 1000);
    },
    modifyArr(context: any, obj: any) {
      setTimeout(() => {
        context.commit("modifyArr", obj);
      }, 2000);
    },
    actionA({ commit }: any) {
      return new Promise((resolve, reject) => {
        setTimeout(() => {
          commit("addCount");
        }, 1000);
        resolve(() => {
          console.log("resolve");
        });
        reject(() => {
          console.log(reject);
        });
      });
    },
  },
  modules: {},
};
