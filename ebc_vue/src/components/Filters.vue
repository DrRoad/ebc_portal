<template>
  <div>
    <h3>Filters</h3>
    <h4>Geographic</h4>
    <tree
      :data="geo" :props="defaultProps"
      :default-checked-keys="geo.children.map(d=>d.name)"
      node-key="name"
      show-checkbox
      :expand-on-click-node = "false"
      @check-change="handleCheckChange" @node-click="handleNodeClick"
    >
    </tree>
    <h4>Habitat</h4>
    <h4>Intervention</h4>
    <h4>Outcome</h4>
  </div>
</template>

<script>
import { Tree } from 'element-ui'
import Geofilters from '../geofilters.js'

export default {
  components: {
    Tree
  },
  data() {
    return {
      geo: Geofilters(),
      defaultProps: {
        children: 'children',
        label: 'name'
      }
    };
  },
  methods: {
    handleCheckChange(data, checked, indeterminate) {
      console.log(data, checked, indeterminate);
    },
    handleNodeClick(data) {
      console.log(data);
    }
  }
};
</script>


<style scoped>

</style>
