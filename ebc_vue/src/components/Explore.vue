<template>
  <div class="row align-items-start">
    <div class="col col-sm-3" style="overflow:auto;height:200px;position:relative;">
      <filters  v-on:checked-nodes="checkHandler"></filters>
    </div>
    <div class="col col-sm-9">
      <p v-if="fulldata.length > 0">{{getCount(filtered)}}</p>
      <p v-else>loading...</p>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import Filters from './Filters.vue'
import {arrayeq} from '../utils.js'
import {set} from 'd3-collection'

export default {
  components: {
    Filters
  },
  data: function() {
    return {
      fulldata: [],
      checkedgeo: [],
      checkedhabitat: [],
      checkedintervention: [],
      checkedoutcome:[]
    }
  },
  computed: {
    filtered: function() {
      debugger
      //if(this.checkedgeo.length > 0) {
        return this.filterData(this.checkedgeo, this.checkedhabitat, this.checkedintervention, this.checkedoutcome)
      //}
    }
  },
  created: function() {
    axios.get('./static/data.json').then(response => {
      this.fulldata = response.data
    })
    .catch(e => {
      console.log('error getting data', e)
      //this.errors.push(e)
    })
  },
  methods: {
    filterData: function(geo, habitat, intervention, outcome) {
      debugger
      return this.fulldata
        .filter(
          d => geo.indexOf(d.subregion) > -1 &&
               habitat.indexOf(d["Biome."]) > -1 && 
               intervention.indexOf(d.Int_type) > -1 &&
               outcome.indexOf(d.Outcome) > -1
        )
    },
    checkHandler: function(type, checkednodes) {
      debugger;
      if(type==="geo") {
        if(!arrayeq(this.checkedgeo,checkednodes.filter(d=>d.colname==="subregion").map(d=>d.name))) {
          this.checkedgeo = checkednodes.filter(d=>d.colname==="subregion").map(d=>d.name)
        }
      }

      if(type==="habitat") {
        if(!arrayeq(this.checkedhabitat,checkednodes.filter(d=>d.colname==="ecoregion").map(d=>d.code))) {
          this.checkedhabitat = checkednodes.filter(d=>d.colname==="ecoregion").map(d=>d.code)
        }
      }

      if(type==="intervention") {
        if(!arrayeq(this.checkedintervention,checkednodes.filter(d=>d.colname==="type").map(d=>d.type_code))) {
          this.checkedintervention = checkednodes.filter(d=>d.colname==="type").map(d=>d.type_code)
        }
      }

      if(type==="outcome") {
        if(!arrayeq(this.checkedoutcome,checkednodes.filter(d=>d.colname==="outcome").map(d=>d.code))) {
          this.checkedoutcome = checkednodes.filter(d=>d.colname==="outcome").map(d=>d.code)
        }
      }
    },
    getCount: function(data) {
      if(Array.isArray(data)) {
        return set(data.map(d=>d.aid)).size();
      }
      return 0
    }
  }
}
</script>

<style scoped>
</style>
