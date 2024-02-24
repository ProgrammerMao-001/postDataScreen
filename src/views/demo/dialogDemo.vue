<template>
  <div class="">
    <el-dialog
      :title="title"
      :visible.sync="dialogVisible"
      width="40%"
      v-el-drag-dialog
      :close-on-click-modal="false"
      :before-close="hideDialog"
    >
      <div class="dialog-content">
        <el-form
          label-width="120px"
          ref="form"
          :model="formData"
          :rules="formRules"
        >
          <div class="main-view-content-header">确诊人信息</div>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item label="确诊人:" prop="name">
                <el-input
                  :disabled="isDisabled"
                  size="small"
                  v-model="formData.name"
                ></el-input>
              </el-form-item>
            </el-col>
          </el-row>
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
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
// import {
//   getDefiniteDetail,
//   updateDefinite,
//   addDefinite,
// } from "@/api/definiteModule";

@Component({
  components: {},
})
export default class PublicDialog extends Vue {
  dialogVisible: boolean = false;
  title: string = "";
  formData: any = {};
  formRules: any = {
    // name: [{ required: true, message: "请输入确诊人", trigger: "blur" }],
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
    // getDefiniteDetail({ id }).then((res: any) => {
    //   if (res.data.status === 200) {
    //     this.formData = res.data.data[0];
    //   }
    // });
  }

  /**
   * 关闭弹窗
   * */
  hideDialog() {
    this.dialogVisible = false;
    this.isDisabled = false;
    this.formData = {};
    (this.$refs.form as any).resetFields();
  }

  /**
   * 确定按钮点击
   * */
  onSubmit() {
    (this.$refs.form as any).validate((valid: any) => {
      if (valid) {
        if (this.title === "编辑") {
          // updateDefinite(this.formData)
          //     .then((res: any) => {
          //       if (res.status === 200) {
          //         this.$message.success("编辑成功！");
          //         this.hideDialog();
          //         (this.$parent as any).getCommentList();
          //       } else {
          //         this.$message.warning(res.message);
          //       }
          //     })
          //     .catch((e: any) => {
          //       throw e;
          //     });
        }
        if (this.title === "新增") {
          // addDefinite(this.formData)
          //     .then((res: any) => {
          //       if (res.status === 200) {
          //         this.$message.success("新增成功！");
          //         this.hideDialog();
          //         (this.$parent as any).getCommentList();
          //       } else {
          //         this.$message.warning(res.message);
          //       }
          //     })
          //     .catch((e: any) => {
          //       throw e;
          //     });
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

.main-view-content-header {
  height: 20px;
  margin: 11px 20px 24px;
  padding-bottom: 10px;
  border-bottom: 1px solid #eee;
  color: $greenBg;
  font-style: italic;
}

::v-deep .el-dialog__body {
  padding: 0 20px 20px !important;
}

::v-deep .el-select {
  width: 100%;
}
</style>
