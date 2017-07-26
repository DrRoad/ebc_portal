<template :fulldata="fulldata">
  <div class="container-fluid" style="margin-top: 2em;">
    <div class="row align-items-start justify-content-center">
      <div class="col col-sm-3" style="overflow:auto;height:200px;position:relative;">
        <filters  v-on:checked-nodes="checkHandler"></filters>
      </div>
      <div class="col col-sm-9">
        <div class="row justify-content-center">
          <div class="col col-md-3">
            <div class="card text-center" style="background-color:#31698a;">
              <div class="card-block">
                <h5 class="card-title">Total Articles</h5>
                <p class="card-text" v-if="fulldata.length > 0">{{getArticleCount(filtered)}}</p>
                <p class="card-text" v-else>loading...</p>
              </div>
            </div>
          </div>
          <div class="col col-md-3">
            <div class="card text-center" style="background-color:#31698a;">
              <div class="card-block">
                <h5 class="card-title">Impact Evaluations</h5>
                <p class="card-text" v-if="fulldata.length > 0">{{getImpactCount(filtered)}}</p>
                <p class="card=text" v-else>loading...</p>
              </div>
            </div>
          </div>
          <div class="col col-md-3">
            <div class="card text-center" style="background-color:#31698a;">
              <div class="card-block">
                <h5 class="card-title">Open Access</h5>
                <p class="card-text" v-if="fulldata.length > 0">{{getOpenCount(filtered)}}</p>
                <p class="card-text" v-else>loading...</p>
              </div>
            </div>
          </div>
        </div>
      </div>
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
  props: ['fulldata'],
  data: function() {
    debugger
    return {
//      fulldata: [],
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
/*
    axios.get('./static/data.json').then(response => {
      this.fulldata = response.data
    })
    .catch(e => {
      console.log('error getting data', e)
      //this.errors.push(e)
    })
  */
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
    getArticleCount: function(data) {
      if(Array.isArray(data)) {
        return set(data.map(d=>d.aid)).size();
      }
      return 0
    },
    getImpactCount: function(data) {
      if(Array.isArray(data)) {
        return set(data.filter(d=>d.IE === "Y").map(d=>d.aid)).size();
      }
      return 0
    },
    getOpenCount: function(data) {
      if(Array.isArray(data)) {
        return set(data.filter(d=>d.FullText === "Y").map(d=>d.aid)).size();
      }
      return 0
    }
  }
}
</script>

<style scoped>
  .card-title, .card-text {color:white;}
</style>
