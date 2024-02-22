<!-- @desc 侧边栏公共组件封装 -->
<template>
  <div>
    <template v-for="item in menuList">
      <!-- 有次级菜单的,则展开子选项-->
      <el-submenu
        v-if="item.children && item.children.length > 0"
        :key="item.id"
        :index="item.id"
      >
        <template #title>
          <i v-if="item.icon" :class="item.icon"></i>
          <span v-show="!isCollapse">{{ item.name }}</span>
        </template>
        <!-- 递归,实现无限级展开 -->
        <side-bar :menuList="item.children"></side-bar>
      </el-submenu>
      <!-- 没有次级菜单的 -->
      <el-menu-item v-if="!item.children" :key="item.id" :index="item.url">
        <i v-if="item.icon" :class="item.icon"></i>
        <span v-show="!isCollapse">{{ item.name }}</span>
      </el-menu-item>
    </template>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";

@Component({
  components: {},
})
export default class SideBar extends Vue {
  @Prop() menuList: any;
  @Prop() isCollapse: any;

  /**
   * @desc isCollapse 解决侧边栏折叠时，还会有多余的字的问题
   */
  created() {}
}
</script>

<style lang="scss"></style>
