<template>
  <div class="">
    <el-dialog
      :title="title"
      :visible.sync="dialogVisible"
      width="40%"
      :close-on-click-modal="false"
      :before-close="hideDialog"
    >
      <div class="dialog-content">
        <el-form label-width="120px" ref="form" :model="formData">
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item label="医院名称:" prop="hname">
                <span> {{ formData.hname }} </span>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="所在地区:" prop="areaid">
                <span> {{ areaName }} </span>
              </el-form-item>
            </el-col>

            <el-col :span="8">
              <el-form-item label="第一针疫苗数:" prop="firstnum">
                <el-input size="small" v-model="formData.firstnum"></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="8">
              <el-form-item label="第二针疫苗数:" prop="secondnum">
                <el-input size="small" v-model="formData.secondnum"></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="8">
              <el-form-item label="第三针疫苗数:" prop="thirdnum">
                <el-input size="small" v-model="formData.thirdnum"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </div>

      <span slot="footer">
        <el-button @click="hideDialog" size="small">取 消</el-button>
        <el-button type="primary" @click="onSubmit" size="small"
          >确 定</el-button
        >
      </span>
    </el-dialog>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import { getHospitalDetail, updateHospital } from "@/api/hospitalModule";
import { arrayToTree } from "@/utils/arrayToTree";
import { getAreaList } from "@/api/areaModule";

@Component({
  components: {},
})
export default class PublicDialog extends Vue {
  dialogVisible: boolean = false;
  title: string = "";
  formData: any = {};
  areaList: any = [];
  areaName: string = "";

  /**
   * 弹窗打开事件
   * */
  async showDialog(data: any) {
    this.title = data.type;
    await this.getAreaList();
    await this.getDetail(data.data.id);
    this.dialogVisible = true;
  }

  /**
   * 获取详情
   * */
  getDetail(id: string) {
    getHospitalDetail({ id }).then((res: any) => {
      if (res.data.status === 200) {
        this.formData = res.data.data[0];
        this.getAreaName(this.formData.areaid);
      }
    });
  }

  /**
   * 关闭弹窗
   * */
  hideDialog() {
    this.dialogVisible = false;
    this.formData = {};
    (this.$refs.form as any).resetFields();
  }

  /**
   * 获取区域列表
   * */
  getAreaList() {
    getAreaList({}).then((res: any) => {
      if (res.data.status === 200) {
        this.areaList = arrayToTree(res.data.data);
      }
    });
  }

  /**
   * 转换数据
   * */
  getAreaName(area: any) {
    let res = "";
    if (area) {
      this.areaList.forEach((item: any, index: any) => {
        item.children.forEach((areaIn: any, areaIndex: any) => {
          if (areaIn.id === area) {
            res = item.city + "/" + areaIn.city;
            this.areaName = res;
          }
        });
      });
    }
  }

  /**
   * 确定按钮点击
   * */
  onSubmit() {
    (this.$refs.form as any).validate((valid: any) => {
      if (valid) {
        updateHospital(this.formData)
          .then((res: any) => {
            if (res.status === 200) {
              this.$message.success("编辑成功！");
              this.hideDialog();
              (this.$parent as any).getHospitalList();
            } else {
              this.$message.warning(res.message);
            }
          })
          .catch((e: any) => {
            throw e;
          });
      } else {
        return false;
      }
    });
  }
}
</script>

<style lang="scss" scoped>
::v-deep .el-dialog {
  min-width: 700px !important;
}

::v-deep .el-dialog__body {
  padding: 0 20px 20px !important;
}
</style>
