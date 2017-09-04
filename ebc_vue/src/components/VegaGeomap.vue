<template>
  <Vega v-if="spec !== null" :spec="spec"></Vega>
</template>

<script>
import Vega from './Vega.vue'

export default {
  components: {
    Vega
  },
  data: function () {
    spec: function() {
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

        ],

        "projections": [
          {
            "name": "projection",
            "type": "mercator",
            "scale": "150"
          }
        ],

        "data": [
          {
            "name": "world",
            "url": "static/world-continents.json",
            "format": {
              "type": "topojson",
              "feature": "continents"
            }
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
                "fill": {"signal": "invert ? '#fff' : '#000'"},
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
    }
  }
}
</script>
