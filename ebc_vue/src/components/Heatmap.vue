<template>
  <svg
   :style = "{'width':'100%', 'height':'100%'}"
   :viewBox = "viewbox"
   preserveAspectRatio="xMidYMin"
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
    <g class="heatmap-xaxis"></g>
    <g class="heatmap-yaxis"></g>
  </svg>  
</template>

<script>
import {scaleBand, scaleLinear, interpolateViridis} from 'd3-scale'
import {set} from 'd3-collection'
import {max} from 'd3-array'
import {select,selectAll} from 'd3-selection'
import {transition} from 'd3-transition'
import {axisTop, axisLeft} from 'd3-axis'
import Vue from 'vue'

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
  data: () => {
    return {
      xadj: 0,
      yadj: 0
    }
  },
  computed: {
    width: function() {
      return this.size[0]
    },
    height: function() {
      return this.size[1]
    },
    viewbox: function() {
      return (-this.xadj) + ',' + (-this.yadj) + ',' + (+this.xadj +this.width) + ',' + (+this.yadj+this.height)
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
  },
  updated: function() {
    this.createXAxis()
    this.createYAxis()
    var vm = this
    Vue.nextTick(function(){vm.adjustViewBox()})
  },
  methods: {
    createXAxis: function() {
      var xaxis = select(this.$el).selectAll(".heatmap-xaxis")
      xaxis.call(
        axisTop()
          .scale(this.xscale)
      )
      xaxis.attr('font-family', 'inherit')
      xaxis.selectAll('.tick text')
        .style('text-anchor', 'start')
        .style('transform', 'rotate(-45deg)')
        .attr('dx', '0.5em')
        .attr('dy', '0.25em')
        .attr('font-family', 'inherit')
    },
    createYAxis: function() {
      var yaxis = select(this.$el).select(".heatmap-yaxis")
      yaxis.call(
        axisLeft()
          .scale(this.yscale)
      )
      yaxis.attr('font-family','inherit')
      yaxis.selectAll('.tick text')
        .attr('font-family','inherit')
    },
    adjustViewBox: function() {
      var xticks = select(this.$el).selectAll('.heatmap-xaxis g.tick')
      if(xticks.nodes().length === 0) {
        return
      }
      this.yadj = max(xticks.nodes().map(d=>d.getBoundingClientRect().height))
      var yticks = select(this.$el).selectAll('.heatmap-yaxis g.tick')
      this.xadj = max(xticks.nodes().map(d=>d.getBoundingClientRect().width))
    }
  }
}
</script>
