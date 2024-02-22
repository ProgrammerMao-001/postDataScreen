import drag from "./drag";
import { DirectiveOptions } from "vue";

const install = function (Vue: any) {
  Vue.directive("el-drag-dialog", drag);
};

if (window.Vue) {
  // @ts-ignore
  window["el-drag-dialog"] = drag;
  // @ts-ignore
  Vue.use(install);
}

// @ts-ignore
drag.install = install;
export default drag;
