<template>
  <div>
    <h4>Filters</h4>

    <h5>
      <a data-toggle="collapse" href="#collapseGeo" aria-expanded="true" aria-controls="collapseGeo">Geographic</a>
    </h5>
    <div class="collapse" id="collapseGeo">
      <tree
        :data="geo" :props="defaultProps"
        :default-checked-keys="geo.map(d=>d.name)"
        node-key="name"
        show-checkbox
        :expand-on-click-node = "false"
        @check-change="handleCheckChange" @node-click="handleNodeClick"
      >
      </tree>
    </div>

    <h5>
    <a data-toggle="collapse" href="#collapseHabitat" aria-expanded="true" aria-controls="collapseHabitat">Habitat</a>
    <div class="collapse" id="collapseHabitat">
      habitat filters
    </div>
    </h5>

    <h5>
    <a data-toggle="collapse" href="#collapseIntervention" aria-expanded="true" aria-controls="collapseIntervention">Intervention</a>
    <div class="collapse" id="collapseIntervention">
      intervention filters
    </div>
    </h5>
    
    <h5>
    <a data-toggle="collapse" href="#collapseOutcome" aria-expanded="true" aria-controls="collapseOutcome">Outcome</a>
    <div class="collapse" id="collapseOutcome">
      outcome filters
    </div>
    </h5>
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
      geo: Geofilters().children,
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
