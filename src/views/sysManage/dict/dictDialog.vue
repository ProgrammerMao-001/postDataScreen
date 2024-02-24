<template>
  <div class="">
    <el-dialog
        :title="title + '字典'"
        :visible.sync="dialogVisible"
        width="200px"
        v-el-drag-dialog
        :close-on-click-modal="false"
        :before-close="hideDialog"
    >
      <div class="dialog-content">
        <el-form
            label-width="88px"
            ref="form"
            :model="formData"
            :rules="formRules"
        >
          <el-form-item label="字典名:" prop="name">
            <el-input
                :disabled="isDisabled"
                size="small"
                v-model="formData.name"
            ></el-input>
          </el-form-item>

          <el-form-item label="字典值:" prop="data" style="height: 200px">
            <vue-json-editor
                v-model="formData.data"
                mode="code"
                lang="zh"
                :expandedOnStart="true"
            >
            </vue-json-editor>
          </el-form-item>

          <el-form-item label="备注:" prop="remark">
            <el-input
                size="small"
                v-model="formData.remark"
                type="textarea"
                :disabled="isDisabled"
            ></el-input>
          </el-form-item>
        </el-form>
      </div>

      <span slot="footer">
        <el-button @click="hideDialog" size="small">取 消</el-button>
        <el-button
            v-if="!isDisabled"
            type="primary"
            @click="onSubmit"
            size="small"
        >确 定</el-button
        >
      </span>
    </el-dialog>
  </div>
</template>

<script lang="ts">
import {Component, Prop, Vue, Watch} from "vue-property-decorator";
import vueJsonEditor from "vue-json-editor/vue-json-editor.vue";
import {getDictDetail, updateDict, addDict} from "@/api/dictModule";

@Component({
  components: {vueJsonEditor},
})
export default class PublicDialog extends Vue {
  dialogVisible: boolean = false;
  title: string = "";
  formData: any = {};
  formRules: any = {
    name: [{required: true, message: "请输入字典名称", trigger: "blur"}],
    data: [{required: true, message: "请输入字典值", trigger: "blur"}],
  };
  isDisabled: boolean = false;

  /**
   * 弹窗打开事件
   * */
  showDialog(data: any) {
    console.log(data);
    this.title = data.type;
    if (this.title === "详情") {
      this.getDetail(data.data.id);
      this.isDisabled = true;
    }
    if (this.title === "编辑") {
      this.getDetail(data.data.id);
    }
    this.dialogVisible = true;
  }

  /**
   * 获取详情
   * */
  getDetail(id: string) {
    getDictDetail({id}).then((res: any) => {
      if (res.data.status === 200) {
        console.log(res, "res")
        this.formData = res.data.data[0];
        this.$set(this.formData, "data", JSON.parse(res.data.data[0].data))
      }
    });
  }

  /**
   * 关闭弹窗
   * */
  hideDialog() {
    console.log('1')
    this.dialogVisible = false;
    this.isDisabled = false;
    (this.$refs.form as any).resetFields();
    this.formData = {};
  }

  /**
   * 确定按钮点击
   * */
  onSubmit() {
    (this.$refs.form as any).validate((valid: any) => {
      if (valid) {
        console.log(this.formData)
        if (this.title === "编辑") {
          updateDict({
            ...this.formData,
            data: JSON.stringify(this.formData.data)
          })
              .then((res: any) => {
                if (res.status === 200) {
                  this.$message.success("编辑成功！");
                  this.hideDialog();
                  (this.$parent as any).getTableData();
                } else {
                  this.$message.warning(res.message);
                }
              })
              .catch((e: any) => {
                throw e;
              });
        }
        if (this.title === "新增") {
          addDict({
            ...this.formData,
            data: JSON.stringify(this.formData.data)
          })
              .then((res: any) => {
                if (res.status === 200) {
                  this.$message.success("新增成功！");
                  (this.$parent as any).getTableData();
                  this.hideDialog();
                } else {
                  this.$message.warning(res.message);
                }
              })
              .catch((e: any) => {
                throw e;
              });
        }
      } else {
        return false;
      }
    });
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/styles/colorMap";

::v-deep .el-dialog {
  min-width: 700px !important;
}

::v-deep .el-dialog__body {
  padding: 20px !important;
}
</style>
