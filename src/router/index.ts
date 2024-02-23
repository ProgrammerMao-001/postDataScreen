import Vue from "vue";
import VueRouter, { RouteConfig } from "vue-router";
import Home from "../components/home.vue";

Vue.use(VueRouter);

const routes: Array<RouteConfig> = [
  // 主页面
  {
    path: "/",
    redirect: "/home",
    name: "Home",
    meta: {
      title: "首页",
    },
    component: Home,
    children: [
      {
        path: "/home",
        name: "home",
        meta: {
          title: "首页",
        },
        component: () =>
          import(/* webpackChunkName: "index" */ "@/views/index.vue"),
      },
    ],
  },

  // 登陆
  // {
  //     path: '/',
  //     redirect: '/login'
  // },
  {
    path: "/login",
    name: "Login",
    meta: {
      title: "登陆",
    },
    component: () =>
      import(
        /* webpackChunkName: "login" */ "../views/loginOrRegister/login.vue"
      ),
  },

  // todo 需要删掉的部分 ********************************** 人员管理  **********************************
  {
    path: "/userManage",
    redirect: "/userManage/peopleManage",
    name: "peopleManage",
    meta: {
      title: "人员管理",
    },
    component: Home,
    children: [
      {
        path: "/userManage/confirmed",
        name: "Confirmed",
        meta: {
          title: "确诊人",
        },
        component: () =>
          import(
            /* webpackChunkName: "confirmed" */ "@/views/sysManage/confirmed/confirmed.vue"
          ),
      },
    ],
  },
  // todo 需要删掉的部分 ********************************** 人员管理 **********************************

  // ********************************** 个人中心 **********************************
  {
    path: "/personalCenter",
    name: "PersonalCenter",
    meta: {
      title: "个人中心",
    },
    component: Home,
    children: [
      {
        path: "/personalCenter",
        name: "PersonalCenter",
        meta: {
          title: "个人中心",
        },
        component: () =>
          import(
            /* webpackChunkName: "personalCenter" */ "@/views/personCenter/personCenter.vue"
          ),
      },
    ],
  },
  // ********************************** 个人中心 **********************************

  // ********************************** 驾驶舱 **********************************
  {
    path: "/dataScreen",
    name: "DataScreen",
    meta: {
      title: "驾驶舱",
    },
    component: () =>
      import(
        /* webpackChunkName: "dataScreen" */ "@/views/dataScreen/dataScreen.vue"
      ),
    // component: Home,
    children: [
      {
        path: "/dataScreen",
        name: "DataScreen",
        meta: {
          title: "个人中心",
        },
        component: () =>
          import(
            /* webpackChunkName: "dataScreen" */ "@/views/dataScreen/dataScreen.vue"
          ),
      },
    ],
  },
  // ********************************** 驾驶舱 **********************************

  // ********************************** 系统管理 **********************************
  {
    path: "/sysManage",
    redirect: "/sysManage/user",
    name: "user",
    meta: {
      title: "系统管理",
    },
    component: Home,
    children: [
      {
        path: "/sysManage/user",
        name: "User",
        meta: {
          title: "用户",
        },
        component: () =>
          import(
            /* webpackChunkName: "user" */ "@/views/sysManage/user/user.vue"
          ),
      },
      {
        path: "/sysManage/role",
        name: "Role",
        meta: {
          title: "角色",
        },
        component: () =>
          import(
            /* webpackChunkName: "role" */ "@/views/sysManage/role/role.vue"
          ),
      },
      {
        path: "/sysManage/dict",
        name: "Dict",
        meta: {
          title: "字典",
        },
        component: () =>
          import(
            /* webpackChunkName: "dict" */ "@/views/sysManage/dict/dict.vue"
          ),
      },
    ],
  },
  // ********************************** 系统管理 **********************************

  // ********************************** 数据管理 **********************************
  {
    path: "/dataManage",
    redirect: "/dataManage/company",
    name: "company",
    meta: {
      title: "公司管理",
    },
    component: Home,
    children: [
      {
        path: "/dataManage/company",
        name: "Company",
        meta: {
          title: "公司",
        },
        component: () =>
          import(
            /* webpackChunkName: "company" */ "@/views/dataManage/company/company.vue"
          ),
      },
      {
        path: "/dataManage/post",
        name: "Post",
        meta: {
          title: "岗位",
        },
        component: () =>
          import(
            /* webpackChunkName: "role" */ "@/views/dataManage/post/post.vue"
          ),
      },
    ],
  },
  // ********************************** 数据管理 **********************************

  // ********************************** 404 **********************************
  {
    path: "/:pathMatch(.*)*",
    name: "NotFound",
    component: () => import("@/views/other/404.vue"),
  },
  // ********************************** 404 **********************************
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

// 导航守卫
// 使用 router.beforeEach 注册一个全局前置守卫，判断用户是否登陆(如果没登录就退出到登陆页面)
router.beforeEach((to, from, next) => {
  if (to.path === "/login") {
    next();
  } else {
    let userInfo: any = localStorage.getItem("userInfo");
    let token = userInfo ? JSON.parse(userInfo).token : null;
    if (token === null || token === "") {
      next("/login");
    } else {
      next();
    }
  }
});
export default router;
