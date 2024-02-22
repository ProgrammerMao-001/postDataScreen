// 输入框自动获取焦点
import { DirectiveOptions } from "vue";

const directive: DirectiveOptions = {
  inserted(el: any, binding, vnode): void {
    el.querySelector("input").focus();
  },
};

export default directive;
