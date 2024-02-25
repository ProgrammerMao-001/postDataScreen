<!--
 * @Description: 企业详情的弹窗 页面
 * @Date: 2024/2/25 21:44
-->
<template>
  <el-dialog
    :title="title"
    :visible.sync="dialogVisible"
    width="60%"
    v-el-drag-dialog
    :close-on-click-modal="false"
    :before-close="hideDialog"
  >
    <div class="dialog-content">
      <el-form label-width="128px" ref="form" :model="formData">
        <el-row :gutter="24">
          <el-col :span="12">
            <el-form-item label="公司名称:">{{ formData.name }}</el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="法定代表人:">{{
              formData.user_name
            }}</el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="成立时间:">{{
              formData.founded
            }}</el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="注册地址:">{{
              formData.address
            }}</el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="统一社会信用代码:">{{
              formData.social_code
            }}</el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item label="登记机关:">{{
              formData.registration_authority
            }}</el-form-item>
          </el-col>

          <el-col :span="24">
            <el-form-item label="经营范围:">{{
              formData.business_scope
            }}</el-form-item>
          </el-col>

          <el-col :span="24">
            <el-form-item label="岗位:">
              <el-table :data="postTable" style="width: 100%">
                <el-table-column label="序号" type="index" />
                <el-table-column
                  prop="name"
                  label="岗位名称"
                  show-overflow-tooltip
                />
                <el-table-column prop="salary_range" label="薪资范围" />
                <el-table-column prop="avg_range" label="平均薪资" />
                <el-table-column
                  prop="desc"
                  label="职位描述"
                  show-overflow-tooltip
                />
              </el-table>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
    </div>
  </el-dialog>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import { getCompanyDetail } from "@/api/companyModule";
import { getPostListByPrams } from "@/api/postModule";

@Component({
  components: {},
})
export default class companyDetailDialog extends Vue {
  dialogVisible: boolean = false;
  title: string = "";
  formData: any = {};
  postTable: any = []; // 岗位表

  /**
   * 弹窗打开事件
   * */
  showDialog(data: any) {
    this.title = data.type;
    this.getDetail(data.data.id);
    this.dialogVisible = true;
  }

  /**
   * 获取详情
   * */
  getDetail(id: string) {
    getCompanyDetail({ id })
      .then((res: any) => {
        if (res.data.status === 200) {
          this.formData = res.data.data[0];
        }
      })
      .then(() => {
        getPostListByPrams({
          company_id: this.formData.id,
        }).then((res: any) => {
          this.postTable = res.data.data;
        });
      });
  }

  /**
   * 关闭弹窗
   * */
  hideDialog() {
    this.dialogVisible = false;
    this.formData = {};
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/styles/colorMap";

::v-deep .el-dialog {
  min-width: 700px !important;
}

::v-deep .el-dialog__body {
  padding: 0 20px 20px !important;
  max-height: 70vh;
  overflow-y: auto;
}
</style>
