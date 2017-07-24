<template>
  <div class="row align-items-start">
    <div class="col col-sm-3" style="overflow:auto;height:200px;position:relative;">
      <filters></filters>
    </div>
    <div class="col col-sm-9">
      <div style="width:100%;"></div>
    </div>
  </div>
</template>

<script>
import Filters from './Filters.vue';

export default {
  components: {
    Filters
  }
}
</script>

<style scoped>
</style>
