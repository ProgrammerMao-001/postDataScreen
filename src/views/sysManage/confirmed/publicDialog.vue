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

            <el-col :span="12">
              <el-form-item label="确诊人联系方式:" prop="namephone">
                <el-input
                  :disabled="isDisabled"
                  size="small"
                  v-model="formData.namephone"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="24">
              <el-form-item label="确诊人治愈情况:" prop="namestatusid">
                <el-select
                  size="small"
                  v-model="formData.namestatusid"
                  :disabled="isDisabled"
                  clearable
                  @change="nameStatusIdChange"
                  placeholder=""
                >
                  <el-option
                    v-for="item in $store.state.dictionaryModule.statusList"
                    :key="item.id"
                    :label="item.status"
                    :value="item.id"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>

            <el-col :span="24">
              <el-form-item label="确诊人隔离地点:" prop="namein">
                <el-input
                  :disabled="isDisabled"
                  type="textarea"
                  rows="3"
                  size="small"
                  v-model="formData.namein"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="24">
              <el-form-item label="确诊人居住地:" prop="namewhere">
                <el-input
                  :disabled="isDisabled"
                  type="textarea"
                  rows="3"
                  size="small"
                  v-model="formData.namewhere"
                ></el-input>
              </el-form-item>
            </el-col>
          </el-row>

          <div class="main-view-content-header">密接人信息</div>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item label="密接人:" prop="staticname">
                <el-input
                  :disabled="isDisabled"
                  size="small"
                  v-model="formData.staticname"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="密接人联系方式:" prop="staticphone">
                <el-input
                  :disabled="isDisabled"
                  size="small"
                  v-model="formData.staticphone"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="24">
              <el-form-item label="密接人治愈情况:" prop="staticstatusid">
                <el-select
                  size="small"
                  v-model="formData.staticstatusid"
                  clearable
                  @change="staticStatusIdChange"
                  :disabled="isDisabled"
                  placeholder=""
                >
                  <el-option
                    v-for="item in $store.state.dictionaryModule.statusList"
                    :key="item.id"
                    :label="item.status"
                    :value="item.id"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>

            <el-col :span="24">
              <el-form-item label="密接人隔离地点:" prop="staticin">
                <el-input
                  :disabled="isDisabled"
                  type="textarea"
                  rows="3"
                  size="small"
                  v-model="formData.staticin"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="24">
              <el-form-item label="密接人居住地:" prop="staticwhere">
                <el-input
                  :disabled="isDisabled"
                  type="textarea"
                  rows="3"
                  size="small"
                  v-model="formData.staticwhere"
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
import {
  getDefiniteDetail,
  updateDefinite,
  addDefinite,
} from "@/api/definiteModule";

@Component({
  components: {},
})
export default class PublicDialog extends Vue {
  dialogVisible: boolean = false;
  title: string = "";
  formData: any = {};
  formRules: any = {
    name: [{ required: true, message: "请输入确诊人", trigger: "blur" }],
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
   * @Interface 接口
   * @description: 获取Vuex中 治愈字典的数据
   * */
  getStatusList() {
    this.$store.dispatch("dictionaryModule/getStatusList");
    console.log(this.$store.state.dictionaryModule.statusList);
  }

  /**
   * 获取详情
   * */
  getDetail(id: string) {
    getDefiniteDetail({ id }).then((res: any) => {
      if (res.data.status === 200) {
        this.formData = res.data.data[0];
      }
    });
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
          if (!this.formData.namestatusid) this.formData.namestatus = "";
          if (!this.formData.staticstatusid) this.formData.staticstatus = "";
          updateDefinite(this.formData)
            .then((res: any) => {
              console.log("res", res);
              if (res.status === 200) {
                this.$message.success("编辑成功！");
                this.hideDialog();
                (this.$parent as any).getCommentList();
              } else {
                this.$message.warning(res.message);
              }
            })
            .catch((e: any) => {
              throw e;
            });
        }
        if (this.title === "新增") {
          addDefinite(this.formData)
            .then((res: any) => {
              if (res.status === 200) {
                this.$message.success("新增成功！");
                this.hideDialog();
                (this.$parent as any).getCommentList();
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

  /**
   * @Event 方法
   * @description: 通过治愈情况id获取治愈状态 确诊人
   * */
  nameStatusIdChange(id: any) {
    this.formData.namestatus =
      this.$store.state.dictionaryModule.statusList.find(
        (item: any) => item.id === id
      ).status;
  }

  /**
   * @Event 方法
   * @description: 通过治愈情况id获取治愈状态 密接人
   * */
  staticStatusIdChange(id: any) {
    this.formData.staticstatus =
      this.$store.state.dictionaryModule.statusList.find(
        (item: any) => item.id === id
      ).status;
  }

  created() {
    this.getStatusList();
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
