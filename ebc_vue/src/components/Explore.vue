<template :fulldata="fulldata">
  <div class="container-fluid" style="margin-top: 2em;">
    <div class="row align-items-start justify-content-center">
      <div class="col col-sm-3" style="overflow:auto;max-height:400px;position:relative;">
        <filters  v-on:checked-nodes="checkHandler"></filters>
      </div>
      <div class="col col-sm-9">
        <div class="row justify-content-center">
          <div class="col col-md-3">
            <h5>Filtered</h5>
            <Treemap
              :tree="filteredtree"
              :tile="tileDice"
              :depth="1"
              :treeheight=100
              :treewidth=200
              :styleObject="{'width':'200px', height:'100px'}"
              :colorScale="colorScaleBW"
              :colorValueFun="colorData"
              :rectStyle="{'stroke':'black'}"
            >
            </Treemap>
          </div>
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
        <div class="row align-items-start" style="margin-top:2em;">
          <div class="col col-sm-5">
            <h5>Geography</h5>
            <Treemap
              :tree="geotree"
              :depth="2"
              :tile="tileBinary"
              :treeheight=400
              :treewidth=400
              :paddingOuter=20
              :styleObject="{'width':'100%', height:'400px'}"
              :rectStyle="{'stroke':'white'}"
            >
            </Treemap>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import {arrayeq} from '../utils.js'
import {set, nest} from 'd3-collection'
import {treemapBinary, treemapDice} from 'd3-hierarchy'
import {scaleOrdinal} from 'd3-scale'
import flattree from '../flattree.js'

import Filters from './Filters.vue'
import Treemap from './Treemap.vue'

export default {
  components: {
    Filters,
    Treemap
  },
  props: ['fulldata'],
  data: function() {
    return {
      checkedfilters: [],
      faketree: {
        name: 'root',
        children: [
          {name: 'A', size:100},
          {name: 'B', size:400},
          {name: 'C', size:600}
        ]
      },
      tileDice: treemapDice,
      tileBinary: treemapBinary,
      colorData: function(d) {return d.data.name},
      colorScaleBW: scaleOrdinal(['#bab','#fff'])
    }
  },
  computed: {
    filtered: function() {
      debugger
      //if(this.checkedgeo.length > 0) {
        return this.filterData(this.checkedfilters)
      //}
    },
    totalcount: function() {
      return this.getArticleCount(this.fulldata)
    },
    filteredcount: function() {
      return this.getArticleCount(this.filtered)
    },
    filteredtree: function() {
      return {
        name: 'root',
        children: [
          {name: 'Filtered', size: this.filteredcount},
          {name: 'Not in Filter', size: this.totalcount - this.filteredcount}
        ]
      }
    },
    geotree: function() {
      debugger;
      var filtered = this.filtered;

      var nested = nest()
        .key(d=>d.subregion)
        .rollup(d=>{return {
          region: d[0].region,
          subregion: d[0].subregion,
          size: set(d.map(dd=>dd.aid)).size()
        }})
        .entries(filtered);
      //flattree(
      //  filtered.map(d=>{return {region:d.region, subregion:d.subregion, aid:d.aid}}),
       // ['region', 'subregion']
      //)
      var ftr = flattree(
        nested.map(d=>d.value),
        ['region','subregion']
      ).each(d=>{
        try {
          d.name = d.data.key
        } catch(e) {}

        try {
          d.size = d.data.values.size
        } catch(e) {}
      });

      return ftr
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
  },
  beforeRouteEnter (to, from, next) {
    next(vm => vm.$emit("minimizeBanner", true))
  },
  beforeRouteLeave (to, from, next) {
    this.$emit("minimizeBanner", false)
    next()
  }
}
</script>

<style scoped>
  .card-title, .card-text {color:white;}
</style>
