<!-- 图片上传组件
 手动上传 需配合按钮或其他自定义事件
 可以多选等
 具体使用方法看@/view/demo/upload
 -->
<template>
  <div class="upload">
    <el-upload
      action=""
      :class="{ hide: isUpload }"
      :auto-upload="autoUpload"
      :http-request="upload"
      list-type="picture-card"
      multiple
      :limit="limit"
      :file-list="fileList"
      :accept="accept"
      ref="upload"
      :name="name"
      :on-change="handleChange"
      :on-exceed="handleExceed"
    >
      <i slot="default" class="el-icon-plus"></i>
      <div slot="file" slot-scope="{ file }">
        <img class="el-upload-list__item-thumbnail" :src="file.url" alt="" />
        <span class="el-upload-list__item-actions">
          <span
            class="el-upload-list__item-preview"
            @click="handlePictureCardPreview(file)"
          >
            <i class="el-icon-zoom-in"></i>
          </span>
          <span
            v-if="!disabled"
            class="el-upload-list__item-delete"
            @click="handleRemove(file)"
          >
            <i class="el-icon-delete"></i>
          </span>
        </span>
      </div>
    </el-upload>
    <el-dialog :visible.sync="dialogVisible">
      <img width="100%" :src="dialogImageUrl" alt="" />
    </el-dialog>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";

@Component({
  components: {},
})
export default class UploadComp extends Vue {
  @Prop({ default: "image/*" }) private accept: any;
  @Prop({ default: 5 }) private limit: any;
  @Prop({ default: "file" }) private name: any;
  @Prop({ default: false }) private autoUpload: any;
  @Prop({ default: [] }) private fileList: any;
  dialogImageUrl: any = "";
  dialogVisible: any = false;
  disabled: any = false;
  isUpload: any = false;

  handleChange(file: any, fileList: any) {
    // 判断上传文件是否达到限制
    this.isUpload = fileList.length >= this.limit;
    // 由于设置自动上传为false,before-upload钩子失效，所以在on-change中检验文件是否符合要求
    const isJPG = ~["image/jpeg", "image/png"].indexOf(file.raw.type);
    const isLt2M = file.raw.size / 1024 / 1024 < 2;
    if (!isJPG) {
      this.$message.error("上传图片只能是 jpg 格式!");
    }
    if (!isLt2M) {
      this.$message.error("上传头像图片大小不能超过 2MB!");
    }
    if (!isJPG || !isLt2M) {
      // 不符合直接删除该文件
      this.handleRemove(file);
    }
  }

  // 删除图片
  handleRemove(file: any) {
    let fileList = (this.$refs.upload as any).uploadFiles;
    let index = fileList.findIndex((fileItem: any) => {
      return fileItem.uid === file.uid;
    });
    fileList.splice(index, 1);
    // 由于删除组件有动画功能，所以设置个延迟显示
    setTimeout(() => {
      this.isUpload = false;
    }, 1000);
  }

  // 预览图片
  handlePictureCardPreview(file: any) {
    this.dialogImageUrl = file.url;
    this.dialogVisible = true;
  }

  // 文件超出限制的提示
  handleExceed(file: any, fileList: any) {
    this.$message.error("文件个数超出限制");
  }

  upload() {
    // const formData = new FormData();
    // const file = this.$refs.uploadImg.$refs.upload.uploadFiles;
    // const headerConfig = {
    //   headers: { "Content-Type": "multipart/form-data" }
    // };
    // file.forEach(item => {
    //   formData.append("file", item.raw)
    // });
    // let {data:res} = await this.$http.post("upload/upload", formData, headerConfig);
    // console.log(res,'res');
  }
}
</script>

<style lang="scss" scoped>
// 设置上传为none，可以加个动画什么之类的
::v-deep .hide .el-upload--picture-card {
  display: none;
}
</style>
