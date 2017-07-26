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
    return {
      checkedfilters: []
    }
  },
  computed: {
    filtered: function() {
      debugger
      //if(this.checkedgeo.length > 0) {
        return this.filterData(this.checkedfilters)
      //}
    }
  },
  methods: {
    filterData: function(filters) {
      var geo = filters.filter(dd=>dd.type==='geo').map(dd=>dd.name); 
      var habitat = filters.filter(dd=>dd.type==='habitat').map(dd=>dd.code);
      var intervention = filters.filter(dd=>dd.type==='intervention').map(dd=>dd.type_code);
      var outcome = filters.filter(dd=>dd.type==='outcome').map(dd=>dd.code);
      
      return this.fulldata
        .filter(
          function(d) {
            debugger

            return geo.indexOf(d.subregion) > -1 &&
               habitat.indexOf(d["Biome."]) > -1 && 
               intervention.indexOf(d.Int_type) > -1 &&
               outcome.indexOf(d.Outcome) > -1
          }
        )
    },
    checkHandler: function(checkednodes) {
      var allfilters = [].concat(checkednodes.filter(d=>d.colname==="subregion").map(d=>{return {type:'geo','id':d.id,'name':d.name}}))
        .concat(checkednodes.filter(d=>d.colname==="ecoregion").map(d=>{return {type:'habitat','id':d.id,'code':d.code}}))
        .concat(checkednodes.filter(d=>d.colname==="type").map(d=>{return {type:'intervention','id':d.id,'type_code':d.type_code}}))
        .concat(checkednodes.filter(d=>d.colname==="outcome").map(d=>{return {type:'outcome','id':d.id,'code':d.code}})
      )
      
      if(!arrayeq(this.checkedfilters, allfilters, function(d){return d.id})) {
        this.checkedfilters = allfilters
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
