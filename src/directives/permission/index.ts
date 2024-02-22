/**
 * @Event 方法
 * @description: 权限控制
 * */
import { DirectiveOptions } from "vue";

const directive: DirectiveOptions = {
  inserted(el, binding, vnode): void {
    let userInfo = JSON.parse(localStorage.getItem("userInfo") as any);
    const role = userInfo.role;
    const roleid = userInfo.roleid;
    if (role === "管理员" && roleid === "1") {
      // 有权限
    } else {
      // 无权限
      el.style.display = "none";
    }
  },
};

export default directive;
