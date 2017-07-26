<template>
  <g :node="node" :rectStyle="rectStyle" :colorScale="colorScale" :colorValueFun="colorValueFun">
    <rect
      v-bind="{
        'x': node.x0, 'width': node.x1 - node.x0,'y': node.y0,
        'height': node.y1 - node.y0,
        'fill': colorScale && colorValueFun ? colorScale(colorValueFun(node)) : 'white'
      }"
      v-bind:style="rectStyle"
    >
    </rect>
  </g>
</template>

<script>
export default {
  props: {
    node: {
      type: Object
    },
    colorScale: {
      type: [Function,Object],
      default: null
    },
    colorValueFun: {
      type: [Function,Object],
      default: null
    },
    rectStyle: {
      type: Object,
      default: () => {return {}}
    }
  }
}
</script>
