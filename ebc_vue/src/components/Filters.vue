<template>
  <div>
    <h4>Filters</h4>

    <h5>
      <a data-toggle="collapse" href="#collapseGeo" aria-expanded="true" aria-controls="collapseGeo">Geographic</a>
    </h5>
    <div class="collapse" id="collapseGeo">
      <tree
        ref = "filter_geotree"
        :data="geo" :props="defaultProps"
        :default-checked-keys="geo.map(d=>d.name)"
        node-key="name"
        show-checkbox
        :expand-on-click-node = "false"
        @check-change="handleGeoChange"
      >
      </tree>
    </div>

    <h5>
    <a data-toggle="collapse" href="#collapseHabitat" aria-expanded="true" aria-controls="collapseHabitat">Habitat</a>
    <div class="collapse" id="collapseHabitat">
      <tree
        ref = "filter_habitattree"
        :data="habitat" :props="defaultProps"
        :default-checked-keys="habitat.map(d=>d.id)"
        node-key="id"
        show-checkbox
        :expand-on-click-node = "false"
        @check-change="handleHabitatChange"
      >
      </tree>
    </div>
    </h5>

    <h5>
    <a data-toggle="collapse" href="#collapseIntervention" aria-expanded="true" aria-controls="collapseIntervention">Intervention</a>
    <div class="collapse" id="collapseIntervention">
      <tree
        ref = "filter_interventiontree"
        :data="intervention" :props="defaultProps"
        :default-checked-keys="intervention.map(d=>d.id)"
        node-key="id"
        show-checkbox
        :expand-on-click-node = "false"
        @check-change="handleInterventionChange"
      >
      </tree>
    </div>
    </h5>
    
    <h5>
    <a data-toggle="collapse" href="#collapseOutcome" aria-expanded="true" aria-controls="collapseOutcome">Outcome</a>
    <div class="collapse" id="collapseOutcome">
      <tree
        ref = "filter_outcometree"
        :data="outcome" :props="defaultProps"
        :default-checked-keys="outcome.map(d=>d.name)"
        node-key="name"
        show-checkbox
        :expand-on-click-node = "false"
        @check-change="handleOutcomeChange"
      >
      </tree>
    </div>
    </h5>
  </div>
</template>

<script>
import { Tree } from 'element-ui'
import GeoFilters from '../geofilters.js'
import HabitatFilters from '../habitatfilters.js'
import InterventionFilters from '../interventionfilters.js'
import OutcomeFilters from '../outcomefilters.js'

export default {
  components: {
    Tree
  },
  data() {
    return {
      geo: GeoFilters().children,
      habitat: HabitatFilters().children,
      intervention: InterventionFilters().children,
      outcome: OutcomeFilters().children,
      defaultProps: {
        children: 'children',
        label: 'name'
      },
      checkedgeo: [],
      checkedhabitat: [],
      checkedintervention: [],
      checkedoutcome: []
    };
  },
  mounted: function() {
    this.handleGeoChange();
    this.handleHabitatChange();
    this.handleInterventionChange();
    this.handleOutcomeChange();
  },
  methods: {
    handleGeoChange(data, checked, indeterminate) {
      this.checkedgeo = this.$refs.filter_geotree.getCheckedNodes()
      this.$emit('checked-nodes', 'geo', this.checkedgeo)
    },
    handleHabitatChange(data, checked, indeterminate) {
      this.checkedhabitat = this.$refs.filter_habitattree.getCheckedNodes()
      this.$emit('checked-nodes', 'habitat', this.checkedhabitat)
    },
    handleInterventionChange(data, checked, indeterminate) {
      this.checkedintervention = this.$refs.filter_interventiontree.getCheckedNodes()
      this.$emit('checked-nodes', 'intervention', this.checkedintervention)
    },
    handleOutcomeChange(data, checked, indeterminate) {
      this.checkedoutcome = this.$refs.filter_outcometree.getCheckedNodes()
      this.$emit('checked-nodes', 'outcome', this.checkedoutcome)
    },
    handleNodeClick(data) {
      console.log(data);
    }
  }
};
</script>


<style scoped>

</style>
