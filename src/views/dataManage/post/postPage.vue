<template>
  <div class="content">
    <!-- 头部 -->
    <div class="main-view-header">
      <div class="main-view-header-left" @click="goBack">
        <i class="el-icon-back"></i>
      </div>
      <div class="main-view-header-right">
        <i class="el-icon-user"></i>
        <span> {{ willPassData.type | getTitle }} </span>
      </div>
    </div>

    <div class="content-main">
      <!-- 岗位信息 -->
      <div class="main-view-content">
        <div class="main-view-content-header">岗位信息</div>
      </div>

      <div class="main-view-main">
        <el-form
          :model="formData"
          :rules="formRules"
          ref="form"
          label-width="150px"
          class=""
        >
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item label="岗位名称：" prop="name">
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.name"
                  size="small"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="职位类型：" prop="post_type">
                <el-cascader
                  size="small"
                  placeholder=""
                  v-model="formData.post_type"
                  :disabled="willPassData.type === '详情'"
                  :options="postTypeList"
                  :props="cascaderProps"
                  filterable
                  clearable
                ></el-cascader>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="招聘状态：" prop="recruitment_status">
                <el-select
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.recruitment_status"
                  placeholder=""
                  size="small"
                  filterable
                >
                  <el-option
                    v-for="item in recruitStatusList"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="学历：" prop="education">
                <el-select
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.education"
                  placeholder=""
                  size="small"
                  filterable
                >
                  <el-option
                    v-for="item in educationList"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="工作年限：" prop="work_life">
                <el-select
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.work_life"
                  placeholder=""
                  size="small"
                  filterable
                >
                  <el-option
                    v-for="item in workExperienceList"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="薪资范围：" prop="salary_range">
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.salary_range"
                  placeholder="格式如：20-40K·16薪(·16薪 可省略，默认为12)"
                  size="small"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="平均薪资：" prop="avg_range">
                <el-input
                  :disabled="willPassData.type === '详情'"
                  v-model="formData.avg_range"
                  placeholder="格式如：40K"
                  size="small"
                ></el-input>
              </el-form-item>
            </el-col>

            <el-col :span="24">
              <el-form-item label="职位描述：" prop="desc">
                <el-input
                  :disabled="willPassData.type === '详情'"
                  :rows="6"
                  v-model="formData.desc"
                  type="textarea"
                />
              </el-form-item>
            </el-col>

            <!-- 公司信息 -->
            <el-col :span="24">
              <div class="main-view-content">
                <div class="main-view-content-header">公司信息</div>
              </div>
            </el-col>

            <el-col :span="24">
              <el-form-item label="企业名称：" prop="company_id">
                <el-select
                  :disabled="willPassData.type === '详情'"
                  @change="companyChange"
                  v-model="formData.company_id"
                  placeholder=""
                  size="small"
                  filterable
                >
                  <el-option
                    v-for="item in companyList"
                    :key="item.id"
                    :label="item.name"
                    :value="item.id"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>

            <el-col :span="24">
              <el-form-item label="工作地址：" prop="company_address">
                <el-input
                  v-model="formData.company_address"
                  placeholder=""
                  disabled=""
                  type="textarea"
                ></el-input>
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </div>
    </div>

    <!-- 底部按钮 -->
    <div class="main-view-btn" v-if="willPassData.type !== '详情'">
      <el-button size="small" icon="el-icon-back" @click="goBack"
        >返回
      </el-button>
      <el-button
        type="primary"
        size="small"
        icon="el-icon-check"
        @click="onsubmit"
        >保存
      </el-button>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";
import { getCompanyListByPrams } from "@/api/companyModule";
import { getPostDetail, addPost, updatePost } from "@/api/postModule";
import postType from "@/utils/postType";
@Component({
  components: {},
  filters: {
    getTitle(value: string): string {
      if (value === "详情") {
        return "岗位" + value;
      } else {
        return value + "岗位";
      }
    },
  },
})
export default class PublicPage extends Vue {
  @Prop() willPassData: any;
  formData: any = {};
  formRules: any = {
    name: [{ required: true, message: "请输入岗位名称", trigger: "blur" }],
    post_type: [
      { required: true, message: "请选择职位类型", trigger: "change" },
    ],
    avg_range: [
      { required: true, message: "请输入平均薪资", trigger: "blur" },
    ],
    company_id: [
      { required: true, message: "请选择关联企业", trigger: "blur" },
    ],
  };
  provinceList: any = []; // 省份列表

  recruitStatusList: any = []; // 招聘状态列表
  educationList: any = []; // 学历列表
  workExperienceList: any = []; // 工作经验列表
  companyList: any = []; // 企业列表
  postTypeList: any = postType(); // 职位类型列表
  cascaderProps: any = {
    children: "subLevelModelList",
    label: "name",
    value: "code",
    expandTrigger: "click",
  }; // 自定义级联列表参数

  /**
   * @desc 返回主页
   */
  goBack() {
    (this.$parent as any).backIndex();
  }

  getMapDialogPoint(obj: any) {
    this.$set(this.formData, "point", JSON.stringify(obj.point));
    this.$set(this.formData, "address", obj.address);
  }

  /**
   * @desc 点击 保存 按钮
   */
  onsubmit() {
    (this.$refs.form as any).validate((valid: any) => {
      if (valid) {
        if (this.willPassData.type === "新增") {
          setTimeout(() => {
            this.addData();
          }, 100);
        }
        if (this.willPassData.type === "编辑") {
          setTimeout(() => {
            this.editData();
          }, 100);
        }
      } else {
        return false;
      }
    });
  }

  /**
   * 新增岗位
   */
  addData() {
    addPost({
      ...this.formData,
      post_type: JSON.stringify(this.formData.post_type)
    })
      .then((res: any) => {
        if (res.status === 200) {
          this.$message.success("新增成功！");
          this.goBack();
          (this.$parent as any).getTableData();
        } else {
          this.$message.warning(res.message);
        }
      })
      .catch((e: any) => {
        throw e;
      });
  }

  /**
   * 编辑岗位
   */
  editData() {
    updatePost({
      ...this.formData,
      post_type: JSON.stringify(this.formData.post_type)
    })
      .then((res: any) => {
        if (res.status === 200) {
          this.$message.success("新增成功！");
          this.goBack();
          (this.$parent as any).getTableData();
        } else {
          this.$message.warning(res.message);
        }
      })
      .catch((e: any) => {
        throw e;
      });
  }

  /**
   * @desc 获取详情的接口
   */
  getDetail() {
    getPostDetail({
      id: this.willPassData.data.id,
    }).then((res: any) => {
      if (res.data.status === 200) {
        this.formData = res.data.data[0];
        if (this.formData.post_type) {
          this.$set(this.formData, "post_type", JSON.parse(this.formData.post_type));
        }
      }
    });
  }

  getProvinceList() {
    (this as any).getDict("province").then((res: any) => {
      let arr = res.data.data[0]?.data || "[]";
      this.provinceList = JSON.parse(arr);
    });
  }

  /* 获取企业列表 */
  getCompanyList() {
    getCompanyListByPrams({}).then((res: any) => {
      this.companyList = res.data.data || [];
    });
  }

  /* 获取招聘状态列表 */
  getRecruitStatusList() {
    (this as any).getDict("recruitmentStatus").then((res: any) => {
      let arr = res.data.data[0]?.data || "[]";
      this.recruitStatusList = JSON.parse(arr);
    });
  }

  /* 获取学历列表 */
  getEducationList() {
    (this as any).getDict("education").then((res: any) => {
      let arr = res.data.data[0]?.data || "[]";
      this.educationList = JSON.parse(arr);
    });
  }

  /* 获取工作经验列表 */
  getWorkExperienceList() {
    (this as any).getDict("workExperience").then((res: any) => {
      let arr = res.data.data[0]?.data || "[]";
      this.workExperienceList = JSON.parse(arr);
    });
  }

  /* 企业选择变化时 */
  companyChange(e: any) {
    let obj = this.companyList.filter((item: any) => item.id === e)[0]
    this.$set(this.formData, "company_name", obj.name)
    this.$set(this.formData, "company_address", obj.address)
    this.$set(this.formData, "company_position", obj.position)
    this.$set(this.formData, "company_province", obj.province)
    this.$set(this.formData, "company_province_id", obj.province_id)
  }

  created() {
    if (this.willPassData.type !== "新增") {
      this.getDetail();
    }
  }

  mounted() {
    this.getProvinceList();

    this.getCompanyList();
    this.getRecruitStatusList();
    this.getEducationList();
    this.getWorkExperienceList();
  }
}
</script>

<style lang="scss" scoped>
@import "~@/assets/styles/colorMap";

.content {
  max-height: calc(80vh - 20px);

  &-main {
    height: calc(80vh - 80px);
    overflow-y: auto;
  }
}

.main-view {
  max-height: 80vh;

  &-header {
    width: 100%;
    height: 50px;
    border-bottom: 1px solid #eee;
    display: flex;
    align-items: center;
    font-size: 15px;
    font-weight: 600;
    color: #666;

    &-left {
      width: 40px;
      height: 24px;
      text-align: center;
      border-right: 1px solid #eee;
      margin: 0 4px;
      cursor: pointer;

      .el-icon-back {
        color: $greenBg;
      }
    }

    &-right {
      .el-icon-user {
        color: $greenBg;
        margin: 0 6px;
      }
    }
  }

  &-content {
    &-header {
      height: 20px;
      margin: 11px 20px 24px;
      padding-bottom: 10px;
      border-bottom: 1px solid #eee;
      color: $greenBg;
      font-style: italic;
    }
  }

  &-main {
    width: 94%;
    margin: 0 auto;
  }

  &-btn {
    width: 94%;
    margin: auto;
    position: absolute;
    bottom: 30px;
    left: 0;
    right: 0;
    display: flex;
    justify-items: right;
    justify-content: flex-end;
  }
}
</style>

<style lang="scss" scoped>
.el-form-item__content .el-input-group {
  vertical-align: baseline !important;
}

.el-input-group__append button.el-button {
  color: #409eff;
}

.el-input--small,
.el-cascader,
.el-select {
  width: 100%;
}
</style>
