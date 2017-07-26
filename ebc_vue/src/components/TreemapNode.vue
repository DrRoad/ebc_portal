<template>
  <g :node="node" :rectStyle="rectStyle" :color="color">
    <rect
      v-bind="{
        'x': node.x0, 'width': node.x1 - node.x0,'y': node.y0,
        'height': node.y1 - node.y0,
        'fill': node.parent && color ? color(node.parent.data.name) : 'white'
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
    color: {
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
