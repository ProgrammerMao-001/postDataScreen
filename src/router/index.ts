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

  // ********************************** 打卡 **********************************
  {
    path: "/clockCard",
    name: "ClockCard",
    meta: {
      title: "打卡",
    },
    component: Home,
    children: [
      {
        path: "/clockCard",
        name: "ClockCard",
        meta: {
          title: "打卡",
        },
        component: () =>
          import(
            /* webpackChunkName: "clockCard" */ "@/views/clockCard/clockCard.vue"
          ),
      },
    ],
  },
  // ********************************** 打卡 **********************************

  // ********************************** 角色管理 **********************************
  {
    path: "/roleManage",
    name: "RoleManage",
    meta: {
      title: "角色管理",
    },
    component: Home,
    children: [
      {
        path: "/roleManage",
        name: "RoleManage",
        meta: {
          title: "角色管理",
        },
        component: () =>
          import(
            /* webpackChunkName: "roleManage" */ "@/views/roleManage/roleManage.vue"
          ),
      },
    ],
  },
  // ********************************** 角色管理 **********************************

  // ********************************** 人员管理 **********************************
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
        path: "/userManage/peopleManage",
        name: "PeopleManage",
        meta: {
          title: "用户",
        },
        component: () =>
          import(
            /* webpackChunkName: "userManage" */ "@/views/sysManage/userManage/userManage.vue"
          ),
      },
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
  // ********************************** 人员管理 **********************************

  // ********************************** 疫苗信息 **********************************
  {
    path: "/vaccineInformation",
    name: "VaccineInformation",
    meta: {
      title: "疫苗信息",
    },
    component: Home,
    children: [
      {
        path: "/vaccineInformation",
        name: "VaccineInformation",
        meta: {
          title: "疫苗信息",
        },
        component: () =>
          import(
            /* webpackChunkName: "vaccineInformation" */ "@/views/vaccineInformation/vaccineInformation.vue"
          ),
      },
    ],
  },
  // ********************************** 疫苗信息 **********************************

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
/* todo 需要修改的地方 --- 路由鉴权 */
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
