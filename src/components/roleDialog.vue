<!-- 选择账号类型 弹窗 -->
<template>
  <div class="">
    <el-dialog
      title="选择账号类型"
      v-el-drag-dialog
      :visible.sync="dialogVisible"
      width="380px"
      :before-close="hideDialog"
    >
      <div>
        <el-input
          placeholder="输入关键字进行过滤"
          size="small"
          v-model="filterText"
        >
        </el-input>

        <el-tree
          class="filter-tree"
          default-expand-all
          node-key="id"
          show-checkbox
          :data="treeData"
          :props="defaultProps"
          :filter-node-method="filterNode"
          :default-checked-keys="checkData"
          @check="checkTree"
          ref="tree"
        >
        </el-tree>
      </div>

      <span slot="footer" class="dialog-footer">
        <el-button @click="hideDialog" size="small">取 消</el-button>
        <el-button type="primary" @click="saveDialog" size="small"
          >确 定</el-button
        >
      </span>
    </el-dialog>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import { getRoleListByName } from "@/api/roleModule";
import { arrayToTree } from "@/utils/arrayToTree";

@Component({
  components: {},
})
export default class roleDialog extends Vue {
  dialogVisible = false;
  filterText: any = "";
  willPassData: any = [];
  treeData: any = [];
  defaultProps: any = {
    children: "children",
    label: "name",
  };
  checkData: any = []; // 默认选中的节点

  @Watch("filterText")
  watchFilterText(newData: any, oldData: any) {
    (this.$refs.tree as any).filter(newData);
  }

  /**
   * 树节点过滤
   */
  filterNode(value: any, data: any) {
    if (!value) return true;
    return data.name.indexOf(value) !== -1;
  }

  /**
   * @desc 当复选框被点击的时候触发
   */
  checkTree(data: any, allData: any) {
    this.willPassData = [];
    this.willPassData.push(data);
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
          // (this.$refs.tree as any).setCheckedKeys([]);
          (this.$refs.tree as any).setCheckedKeys([data.id]);
          return;
        }
      } else {
        // this.$message.error("只能选择当前分类最后的子分类");
        (this.$refs.tree as any).setCheckedKeys([]);
        return;
      }
    }
  }

  /**
   * 获取树的数据
   */
  getTreeData() {
    getRoleListByName({}).then((res: any) => {
      if (res.data.status === 200) {
        this.treeData = arrayToTree(res.data.data);
      }
    });
  }

  /**
   * @desc 打开弹窗事件
   * 回显需要的数据 id 即可
   */
  showDialog(data: any) {
    this.getTreeData();
    this.dialogVisible = true;
    this.checkData.push(data);
  }

  /**
   * @desc 关闭弹窗事件
   */
  hideDialog() {
    this.checkData = [];
    this.dialogVisible = false;
    (this.$refs.tree as any).setCheckedKeys([]);
  }

  /**
   * @desc 点击确定
   * 将选中的数据传递给父组件（需要的数据：id，name）
   */
  saveDialog() {
    this.$emit("on-response", this.willPassData);
    this.hideDialog();
  }
}
</script>

<style lang="scss" scoped></style>
