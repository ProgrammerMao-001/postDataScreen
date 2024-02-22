<!-- 左侧树 -->
<template>
  <div class="">
    <div class="l-content">
      <div class="l-content-header">
        <div class="l-content-header-left">
          <i class="el-icon-menu"></i>
          <span> 用户权限 </span>
        </div>
        <div class="l-content-header-right">
          <i
            :class="[flag ? 'el-icon-arrow-up' : 'el-icon-arrow-down']"
            @click="hiddenTree"
          ></i>
          <i class="el-icon-refresh" @click="refreshTree"></i>
        </div>
      </div>
      <div class="l-content-center">
        <span> 是否关联： </span>
        <el-radio-group @change="isRelationChange" v-model="isRelation">
          <el-radio label="true" value="true">是</el-radio>
          <el-radio label="false" value="false">否</el-radio>
        </el-radio-group>
      </div>
      <div class="l-content-main">
        <el-tree
          :data="treeData"
          show-checkbox
          default-expand-all
          node-key="id"
          ref="tree"
          highlight-current
          :check-strictly="!JSON.parse(isRelation)"
          @check="checkTree"
        >
          <span class="l-content-main-tree" slot-scope="{ node, data }">
            <i v-if="data.children" class="el-icon-user-solid"></i>
            <i v-if="!data.children" class="el-icon-user"></i>
            <span style="margin-left: 4px">{{ data.name }}</span>
          </span>
        </el-tree>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import { getRoleListByName } from "@/api/roleModule";
import { arrayToTree } from "@/utils/arrayToTree";

@Component({
  components: {},
})
export default class TreeComp extends Vue {
  isRelation: any = "true";
  treeData: any = [];
  flag: any = false;
  willPassData: any = []; // 需要传给父组件的数据，即请求接口的参数

  /**
   * @desc 按钮切换事件
   **/
  isRelationChange(value: any) {
    (this.$refs.tree as any).setCheckedKeys([]);
    this.isRelation = value;
  }

  /**
   * 选项清空
   */
  clearCheck() {
    (this.$refs.tree as any).setCheckedKeys([]);
  }

  /**
   * @desc 获取树的数据
   */
  getTreeData() {
    getRoleListByName({})
      .then((res: any) => {
        if (res.data.status === 200) {
          this.treeData = arrayToTree(res.data.data);
        }
      })
      .catch((e: any) => {
        this.$message.error("获取树的数据失败!");
        throw e;
      });
  }

  /**
   * @desc 当复选框被点击的时候触发
   */
  checkTree(data: any, allData: any) {
    // console.log(data, allData)
    // console.log(this.isRelation)
    this.willPassData = [];
    if (this.isRelation === "true") {
      allData.checkedNodes.forEach((item: any) => {
        this.willPassData.push(item.name);
      });
      // console.log(this.willPassData, 1)
      this.$emit("on-response", this.willPassData);
    }

    if (this.isRelation === "false") {
      this.willPassData.push(data.name);
      this.$emit("on-response", this.willPassData);
      // console.log(this.willPassData, 2)
      var getlist = (this.$refs.tree as any)
        .getCheckedNodes()
        .concat((this.$refs.tree as any).getHalfCheckedNodes());
      // 循环遍历当前节点的值
      for (var i in getlist) {
        // 判断子节点是否存在子节点 如果存在直接请求并且提示 false
        if (!getlist[i].hasOwnProperty("children")) {
          // 判断是否只选择一个 如果存在直接请求并且提示 false
          if (getlist.length == 1) {
            // console.log(getlist[0].id)
          } else {
            // this.$message.error("只选择一个节点");
            (this.$refs.tree as any).setCheckedKeys([]);
            (this.$refs.tree as any).setCheckedKeys([data.id]);
            return;
          }
        } else {
          this.$message.error("只能选择当前分类最后的子分类");
          (this.$refs.tree as any).setCheckedKeys([]);
          return;
        }
      }
    }
  }

  /**
   * @desc 展开/收起树
   */
  hiddenTree() {
    var nodes = (this.$refs.tree as any).store.nodesMap;
    for (var i in nodes) {
      nodes[i].expanded = this.flag;
    }
    this.flag = !this.flag;
  }

  /**
   * @desc 刷新树的数据
   */
  refreshTree() {
    this.getTreeData();
  }

  created() {
    this.getTreeData();
  }
}
</script>

<style lang="scss" scoped>
.l-content {
  &-header {
    border-bottom: 1px solid #eee;
    height: 30px;
    display: flex;
    justify-content: space-between;
    margin: 20px 16px 0;

    &-left {
      font-size: 15px;
      margin-left: 4px;
      font-weight: 600;
      color: #666;

      .el-icon-menu {
        color: #2244ff;
      }
    }

    &-right {
      width: 42px;
      font-size: 14px;
      color: #666;

      .el-icon-arrow-down,
      .el-icon-arrow-up {
        margin-right: 6px;
      }

      .el-icon-refresh,
      .el-icon-arrow-down,
      .el-icon-arrow-up {
        cursor: pointer;
      }
    }
  }

  &-center {
    margin: 10px 0 0 12px;
    display: flex;
    font-size: 14px;
    color: #666;
  }

  &-main {
    padding: 10px;

    &-tree {
      font-size: 14px;
      color: #666;
    }
  }
}

::v-deep .el-radio-group {
  display: flex;
  margin-top: 3px;

  .el-radio {
    margin-right: 10px !important;
  }
}
</style>
