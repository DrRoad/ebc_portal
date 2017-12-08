<template :fulldata="fulldata">
  <div class="container-fluid" style="margin-top: 2em;">
    <Navbar></Navbar>
    <div class="col-md-3" style="overflow:auto; min-height: 100px; max-height:400px; position:fixed; top:150px;">
      <h4>Filters</h4>
      <filters  v-on:checked-nodes="checkHandler"></filters>
    </div>
    <nuxt></nuxt>
  </div>
</template>

<script>
  import axios from 'axios'
  import {arrayeq} from '~/assets/utils.js'

  import Navbar from '~/components/Navbar.vue'
  import Filters from '~/components/Filters.vue'

  export default {
    components: {
      Navbar,
      Filters
    },
    created: function() {
      axios.get('articles_profor.json').then(response => {
        this.articles = response.data
      })
      .catch(e => {
        console.log('error getting data', e)
        //this.errors.push(e)
      })
      axios.get('data_profor.json').then(response => {
        this.fulldata = response.data
      })
      .catch(e => {
        console.log('error getting data', e)
        //this.errors.push(e)
      })
    },
    data: function() {
      return {
        articles: [],
        fulldata: [],
        checkedfilters: []
      }
    },
    computed: {
      filtered: function() {
        //if(this.checkedgeo.length > 0) {
          return {
            data: this.filterData(this.checkedfilters),
            filters_geo: this.checkedfilters.filter(dd=>dd.type==='geo').map(dd=>dd.name),
            filters_int: this.checkedfilters.filter(dd=>dd.type==='intervention').map(dd=>dd.type_code),
            filters_hab: this.checkedfilters.filter(dd=>dd.type==='habitat').map(dd=>dd.code),
            filters_out: this.checkedfilters.filter(dd=>dd.type==='outcome').map(dd=>dd.code)
          }
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
              var foundgeo =  d.geo.some(function(dd) {
                return geo.indexOf(dd.subregion) > -1
              })
              var foundhab = d.habitat.some(function(dd) {
                return habitat.indexOf(dd['Biome.']) > -1
              })
              var foundint = d.intervention.some(function(dd) {
                return intervention.indexOf(dd['Int_type']) > -1
              })
              var foundout = d.outcome.some(function(dd) {
                return outcome.indexOf(dd['Out_subtype']) > -1
              })
              return foundgeo && foundhab && foundint && foundout
                /*
                intervention.indexOf(d.Int_type) > -1 &&
                outcome.indexOf(d.Outcome) > -1
                */
            }
          )
      },
      checkHandler: function(checkednodes) {
        var allfilters = [].concat(checkednodes.filter(d=>d.colname==="subregion").map(d=>{return {type:'geo','id':d.id,'name':d.name}}))
          .concat(checkednodes.filter(d=>d.colname==="ecoregion").map(d=>{return {type:'habitat','id':d.id,'code':d.code}}))
          .concat(checkednodes.filter(d=>d.colname==="type").map(d=>{return {type:'intervention','id':d.id,'type_code':d.type_code}}))
          .concat(checkednodes.filter(d=>d.colname==="outcome").map(d=>{return {type:'outcome','id':d.id,'code':d.code}}))
        
        if(!arrayeq(this.checkedfilters, allfilters, function(d){return d.id})) {
          this.checkedfilters = allfilters
        }
      }
    }
  }
</script>
