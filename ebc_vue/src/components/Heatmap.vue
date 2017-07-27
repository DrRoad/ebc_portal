<template>
  <svg
   :style = "{'width':'100%', 'height':'100%'}"
   :viewBox = "'0,0,' + width + ',' + height"
   preserveAspectRatio="xMidYMin">
  >
    <g
       v-for="(node, index) in matrix"
          v-bind:key="index"
          :transform="'translate(' + xscale(node[x]) + ',' + yscale(node[y]) +')'"
    >
      <rect
        :width = "xscale.bandwidth()"
        :height = "yscale.bandwidth()"
        :style = "{'fill': color()(zscale(node[z])), 'stroke':'white'}"
      >
      </rect>
    </g>
  </svg>  
</template>

<script>
import {scaleBand, scaleLinear, interpolateViridis} from 'd3-scale'
import {set} from 'd3-collection'
import {max} from 'd3-array'

export default {
  props: {
    matrix: {
      type: Array,
      default: []
    },
    x: {
      type: String,
      default: 'x'
    },
    y: {
      type: String,
      default: 'y'
    },
    z: {
      type: String,
      default: 'z'
    },
    size: {
      type: Array,
      default: () => [1,1]
    },
    color: {
      type: Function,
      default: () => interpolateViridis
    }
  },
  computed: {
    width: function() {
      return this.size[0]
    },
    height: function() {
      return this.size[1]
    },
    xvals: function() {
      var vm = this
      return set(vm.matrix.map(d=>d[vm.x]))
    },
    yvals: function() {
      var vm = this
      return set(vm.matrix.map(d=>d[vm.y]))
    },
    xscale: function() {
      return scaleBand().domain(this.xvals.values()).range([0,this.width]).round(true)
    },
    yscale: function() {
      return scaleBand().domain(this.yvals.values()).range([this.height,0]).round(true)
    },
    zscale: function() {
      window.color = this.color
      window.zscale = scaleLinear().domain([0,max(this.matrix.map(d=>d[this.z]))]).range([0,1])
      return scaleLinear().domain([0,max(this.matrix.map(d=>d[this.z]))]).range([0,1])
    }
  }
}
</script>
