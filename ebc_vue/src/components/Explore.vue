<template :fulldata="fulldata">
  <div class="container-fluid" style="margin-top: 2em;">
    <div class="row align-items-start justify-content-center">
      <div class="col col-md-3" style="overflow:auto;max-height:400px;position:relative;">
        <filters  v-on:checked-nodes="checkHandler"></filters>
      </div>
      <div class="col col-md-9">
        <div class="row justify-content-center">
          <div class="col col-md-3">
            <h5>Filtered</h5>
            <Treemap
              :tree="filteredtree"
              :tile="tileDice"
              :depth="1"
              :treeheight=100
              :treewidth=200
              :styleObject="{'width':'100%', height:'100px'}"
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
          <VegaGeomap :spec = "spec_geo"></VegaGeomap>
        </div>
        <div class="row align-items-start" style="margin-top:2em;">
          <div class="col col-md-6">
            <h5>Vega Heatmap</h5>
            <VegaHeatmap
              :matrix = "matrix_intout"
              x = "outcome"
              y = "int_group"
              z = "size"
            >
            </VegaHeatmap>
          </div>
          <div class="col col-md-6">
            <h5>Vega Bar</h5>
            <VegaBarChart
              :matrix = "matrix_intout"
              y = "int_group"
              x = "size"
            >
            </VegaBarChart>
          </div>
        </div>
        <div class="row align-items-start" style="margin-top:2em;">
          <div class="col col-md-12">
            <h5>Vega Facet Bar</h5>
            <VegaBarFacet
              :matrix = "matrix_geoint"
              x = "size"
              y = "intgroup"
              facet = "region"
            >
            </VegaBarFacet>
          </div>
        </div>
        <div class="row align-items-start" style="margin-top:2em;">
          <div class="col col-md-12">
            <h5>Vega Facet Dot</h5>
            <VegaDotFacet
              :matrix = "matrix_geoint"
              x = "size"
              y = "intgroup"
              facet = "region"
            >
            </VegaDotFacet>
          </div>
        </div>
        <div class="row align-items-start" style="margin-top:2em;">
          <div class="col col-md-4">
            <h5>Treemap Geography</h5>
            <Treemap
              :tree="geotree"
              :depth="2"
              :tile="tileBinary"
              :treeheight=400
              :treewidth=400
              :paddingOuter=20
              :styleObject="{'width':'100%', height:'400px'}"
              :colorScale="colorScaleGrayStart"
              :rectStyle="{'stroke':'white'}"
            >
            </Treemap>
          </div>
          <div class="col col-md-8">
            <h5>Custom Heatmap</h5>
            <Heatmap :matrix="matrix_intout" :size="[300,200]" x="int_group" y="outcome" z="size"></Heatmap>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {arrayeq} from '../utils.js'
import {set, nest} from 'd3-collection'
import {hierarchy, treemapBinary, treemapDice} from 'd3-hierarchy'
import {scaleOrdinal, schemeCategory10} from 'd3-scale'
import {merge} from 'd3-array'
import * as vegalite from 'vega-lite'
import flattree from '../flattree.js'

import Filters from './Filters.vue'
import Treemap from './Treemap.vue'
import Heatmap from './Heatmap.vue'
import VegaHeatmap from './VegaHeatmap.vue'
import VegaGeomap from './VegaGeomap.vue'
import VegaBarChart from './VegaBarChart.vue'
import VegaBarFacet from './VegaBarFacet.vue'
import VegaDotFacet from './VegaDotFacet.vue'

export default {
  components: {
    Filters,
    Treemap,
    Heatmap,
    VegaHeatmap,
    VegaGeomap,
    VegaBarChart,
    VegaBarFacet,
    VegaDotFacet
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
      colorScaleGrayStart: scaleOrdinal(['#ded'].concat(schemeCategory10)),
      colorScaleBW: scaleOrdinal(['#bab','#fff'])
    }
  },
  computed: {
    filtered: function() {
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
      var filtered = this.filtered;

      var nested = nest()
        .key(d=>d.subregion)
        .rollup(d=>{return {
          region: d[0].region,
          subregion: d[0].subregion,
          size: set(d.map(dd=>dd.aid)).size()
        }})
        .entries(filtered);

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
    },
    spec_geo: function() {
      var filtered = this.filtered;
      debugger;
      var nested = nest()
        .key(d=>d.id)
        .rollup(d=>{return {
          id: d[0].id,
          size: set(d.map(dd=>dd.aid)).size()
        }})
        .entries(filtered);
      return {        
        "$schema": "https://vega.github.io/schema/vega/v3.0.json",
        "width": 900,
        "height": 500,
        "autosize": "none",

        "encode": {
          "update": {
            "fill": {"signal": "background"}
          }
        },

        "signals": [
          { "name": "scale", "value": 150,
            "bind": {"input": "range", "min": 50, "max": 2000, "step": 1} },
          { "name": "rotate0", "value": 0,
            "bind": {"input": "range", "min": -180, "max": 180, "step": 1} },
          { "name": "rotate1", "value": 0,
            "bind": {"input": "range", "min": -90, "max": 90, "step": 1} },
          { "name": "rotate2", "value": 0,
            "bind": {"input": "range", "min": -180, "max": 180, "step": 1} },
          { "name": "center0", "value": 0,
            "bind": {"input": "range", "min": -180, "max": 180, "step": 1} },
          { "name": "center1", "value": 0,
            "bind": {"input": "range", "min": -90, "max": 90, "step": 1} },
          { "name": "translate0", "update": "width / 2" },
          { "name": "translate1", "update": "height / 2" },

          { "name": "graticuleDash", "value": 0,
            "bind": {"input": "radio", "options": [0, 3, 5, 10]} },
          { "name": "borderWidth", "value": 1,
            "bind": {"input": "text"} },
          { "name": "background", "value": "#ffffff",
            "bind": {"input": "color"} },
          { "name": "invert", "value": false,
            "bind": {"input": "checkbox"} }
        ],

        "projections": [
          {
            "name": "projection",
            "type": "mercator",
            "scale": {"signal": "scale"},
            "rotate": [
              {"signal": "rotate0"},
              {"signal": "rotate1"},
              {"signal": "rotate2"}
            ],
            "center": [
              {"signal": "center0"},
              {"signal": "center1"}
            ],
            "translate": [
              {"signal": "translate0"},
              {"signal": "translate1"}
            ]
          }
        ],

        "data": [
          {
            "name": "geosum",
            "values": nested.map(d=>d.value)
          },
          {
            "name": "world",
            "url": "static/world-110m.json",
            "format": {
              "type": "topojson",
              "feature": "countries"
            },
            "transform": [
              { "type": "lookup", "from": "geosum", "key": "id", "fields": ["id"], "values": ["size"], "default": 0 }//,
              //{ "type": "filter", "expr": "datum.size != null" }
            ]
          },
          {
            "name": "graticule",
            "transform": [
              { "type": "graticule" }
            ]
          }
        ],

        "scales": [
          {
            "name": "color",
            "type": "quantize",
            "domain": {"data": "geosum", "field": "size"},
            "range": {"scheme": "blues"}
          }
        ],

        "marks": [
          {
            "type": "shape",
            "from": {"data": "graticule"},
            "encode": {
              "update": {
                "strokeWidth": {"value": 1},
                "strokeDash": {"signal": "[+graticuleDash, +graticuleDash]"},
                "stroke": {"signal": "invert ? '#444' : '#ddd'"},
                "fill": {"value": null}
              }
            },
            "transform": [
              { "type": "geoshape", "projection": "projection" }
            ]
          },
          {
            "type": "shape",
            "from": {"data": "world"},
            "encode": {
              "update": {
                "strokeWidth": {"signal": "+borderWidth"},
                "stroke": {"signal": "invert ? '#777' : '#bbb'"},
                "fill": {"scale": "color", "field": "size"},
                "zindex": {"value": 0}
              },
              "hover": {
                "strokeWidth": {"signal": "+borderWidth + 1"},
                "stroke": {"value": "firebrick"},
                "zindex": {"value": 1}
              }
            },
            "transform": [
              { "type": "geoshape", "projection": "projection" }
            ]
          }
        ]
      }
    },
    matrix_intout: function() {
      var filtered = this.filtered;

      var nested = nest()
        .key(d=>d.int_group)
        .key(d=>d.Outcome)
        .rollup(d=>{ return {
          int_group: d[0].int_group,
          outcome: d[0].Outcome,
          size: set(d.map(dd=>dd.aid)).size()
        }})
        .entries(filtered)
        .map(d=>d.values.map(dd=>dd.value));

      return merge(nested)
    },
    matrix_geoint: function() {
      var filtered = this.filtered;

      var nested = nest()
        .key(d=>d.region)
        .key(d=>d.int_group)
        .rollup(d=>{ return {
          region: d[0].region,
          intgroup: d[0].int_group,
          size: set(d.map(dd=>dd.aid)).size()
        }})
        .entries(filtered)
        .map(d=>d.values.map(dd=>dd.value));
      return merge(nested)
    },
    fakehier: function () {
      return hierarchy(this.faketree)
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
