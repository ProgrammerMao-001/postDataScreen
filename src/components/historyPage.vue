<!-- todo 历史记录标签，后续新增 在标签上右击实现 关闭左侧/关闭右侧/关闭全部 的功能 -->
<template>
  <div class="tabs-view-container">
    <router-link
      class="tags-view-item"
      :class="isActive(tag) ? 'active' : ''"
      v-for="(tag, index) in visitedTabsView"
      :to="tag.path"
      :key="index"
    >
      <el-tag
        type="danger"
        v-if="tag.name === '首页'"
        :disable-transitions="false"
        @close.prevent.stop="handleClose(tag)"
        @contextmenu.prevent.native="openRightMenu($event, tag, index)"
        effect="plain"
      >
        {{ tag.name }}
      </el-tag>
      <el-tag
        v-else
        type="danger"
        closable
        :disable-transitions="false"
        @close.prevent.stop="handleClose(tag)"
        @contextmenu.prevent.native="openRightMenu($event, tag, index)"
        effect="plain"
      >
        {{ tag.name }}
      </el-tag>
    </router-link>

    <!-- 右击出现的菜单项 -->
    <!-- 首页点击是出现 关闭全部、取消 -->
    <!-- 其他标签点击是出现 关闭当前项、关闭左侧、关闭右侧、关闭全部、回到首页、取消 -->
    <div class="right-menu" id="menu">
      <div class="right-menu-box" style="border-top: none" @click="closeLeft">
        关闭左侧
      </div>
      <div class="right-menu-box" @click="closeRight">关闭右侧</div>
      <div class="right-menu-box" @click="closeAll">关闭全部</div>
      <div class="right-menu-box" @click="closeOther">关闭其他</div>
    </div>

    <!-- 当溢出时，展示左右箭头 -->
    <!--        <div class="public-side-icon">-->
    <!--            <i class="el-icon-arrow-left"></i>-->
    <!--        </div>-->

    <!--        <div class="public-side-icon">-->
    <!--            <i class="el-icon-arrow-right"></i>-->
    <!--        </div>-->
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";

export default {
  name: "historyPage",
  data() {
    return {
      tagObj: {
        allList: [], // 所有的Tags数组
        willDelTag: {}, // 当前右击的Tag
        tagIndex: 0, // 右击的标签在数组中的位置
      },
    };
  },
  created() {
    this.addTabsView();
  },
  computed: {
    ...mapGetters(["visitedTabsView"]),
  },
  methods: {
    ...mapActions([
      "addVisitedTabsView",
      "delVisitedTabsView",
      "resetTabsView",
      "otherTabsView",
    ]),
    addTabsView() {
      const route = this.generateRoute();
      if (!route) {
        return false;
      }
      this.addVisitedTabsView(this.generateRoute());
      this.tagObj.allList = this.visitedTabsView;
    },
    generateRoute() {
      if (this.$route.name) {
        return this.$route;
      }
      return false;
    },
    isActive(route) {
      return route.path === this.$route.path || route.name === this.$route.name;
    },
    handleClose(tag) {
      this.delVisitedTabsView(tag).then((tags) => {
        // 如果关闭的是当前显示的页面，就去到前一个 tab-view 页面
        if (this.isActive(tag)) {
          const lastTag = tags.slice(-1)[0];
          // 前一个 tab-view 页面存在，就跳；不存在就到首页
          if (lastTag) {
            this.$router.push(lastTag.path);
          } else {
            this.$router.push("/home");
          }
        }
      });
      this.tagObj.allList = this.visitedTabsView;
    },

    /**
     * el-tag 右击
     * 出现右键盒子
     * 存储 tag 和 index
     * */
    openRightMenu(event, tag, index) {
      // console.log(event, tag, index)
      this.tagObj.willDelTag = tag;
      this.tagObj.tagIndex = index;
      let menu = document.querySelector("#menu");
      document.addEventListener("click", this.unShowMenu); // 给整个document添加监听鼠标事件，点击任何位置执行unShowMenu方法
      menu.style.display = "block";
      menu.style.left = event.clientX - 220 + "px";
      menu.style.top = event.clientY - 60 + "px";
    },

    /**
     * 点击任何地方取消右键
     * */
    unShowMenu() {
      let menu = document.querySelector("#menu");
      menu.style.display = "none";
    },

    /**
     * 关闭左侧
     * */
    closeLeft() {
      if (this.tagObj.tagIndex === 1) {
        this.$message.error("必须固定首页在最左侧嗷！");
        return false;
      }
      if (this.tagObj.tagIndex === 0) {
        this.$message.error("左侧已经没有标签了嗷！");
        return false;
      }
      this.tagObj.allList.splice(1, this.tagObj.tagIndex - 1);
      // 以下这一步是为了判断是否在亮起的tag标签上点击的删除
      if (this.$route.path !== this.tagObj.willDelTag.path) {
        this.$router.push(this.tagObj.willDelTag.path);
      }
    },

    /**
     * 关闭右侧
     * */
    closeRight() {
      console.log(this.tagObj);
      if (this.tagObj.tagIndex === this.tagObj.allList.length - 1) {
        // 是最后一项
        this.$message.error("右侧已经没有标签了嗷！");
        return false;
      }
      this.tagObj.allList.splice(
        this.tagObj.tagIndex + 1,
        this.tagObj.allList.length - 1
      );
      // 以下这一步是为了判断是否在亮起的tag标签上点击的删除
      if (this.$route.path !== this.tagObj.willDelTag.path) {
        this.$router.push(this.tagObj.willDelTag.path);
      }
    },

    /**
     * 关闭全部
     * */
    closeAll() {
      if (this.tagObj.allList.length === 1) {
        // 只有一项
        this.$message.error("必须保留一个首页标签嗷！");
        return false;
      }
      this.resetTabsView();
      if (this.$route.name !== "首页") {
        this.$router.push("/home");
      }
    },

    /**
     * 关闭其他
     * */
    closeOther() {
      console.log(this.tagObj);
      if (this.tagObj.allList.length === 1) {
        // 只有一项
        this.$message.error("必须保留一个首页标签嗷！");
        return false;
      }
      if (
        this.tagObj.allList.length === 2 &&
        this.tagObj.willDelTag.name !== "首页"
      ) {
        // 只有两项且点击的不是首页标签
        this.$message.error("没有其他标签可以删除了！");
        return false;
      }
      if (
        this.tagObj.allList.length === 2 &&
        this.tagObj.willDelTag.name === "首页"
      ) {
        // 只有两项且点击的是首页标签
        this.resetTabsView();
        if (this.$route.name !== "首页") {
          this.$router.push("/home");
        }
      }
      let arr = [
        {
          name: "首页",
          path: "/home",
        },
      ];
      if (this.tagObj.willDelTag.name !== "首页")
        arr.push(this.tagObj.willDelTag);
      this.otherTabsView(arr);
      // 以下这一步是为了判断是否在亮起的tag标签上点击的删除
      if (this.$route.path !== this.tagObj.willDelTag.path) {
        this.$router.push(this.tagObj.willDelTag.path);
      }
    },
  },
  watch: {
    $route() {
      this.addTabsView();
    },
  },
};
</script>

<style lang="scss" scoped>
/*//滚动条的宽度*/
/*::-webkit-scrollbar {*/
/*    width: 2px;*/
/*    height: 2px;*/
/*}*/
</style>
