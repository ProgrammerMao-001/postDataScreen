<template>
  <div class="main-view">companyPage</div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from "vue-property-decorator";

@Component({
  components: {},
})
export default class companyPage extends Vue {
  @Prop() passData: any;

  created() {
    console.log(this.passData, "passData");
  }
}
</script>

<style lang="scss" scoped></style>
