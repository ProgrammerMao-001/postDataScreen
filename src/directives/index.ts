import { VueConstructor } from "vue";
import focus from "./focus";
import elDragDialog from "./el-dragDialog";
import permission from "./permission";

export default function install(Vue: VueConstructor) {
  Vue.directive("focus", focus); // 输入框自动获取焦点
  Vue.directive("elDragDialog", elDragDialog); // 弹窗可拖拽
  Vue.directive("permission", permission); // 控制权限
}
