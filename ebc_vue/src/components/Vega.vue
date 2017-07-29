<template>
  <div></div>
</template>

<script>
import * as vega from 'vega';
import {select} from 'd3-selection';

export default {
  props: {
    spec: {
      type: Object,
      default: null
    },
    renderer: {
      default: 'svg'
    },
    autosize: {
      type: Object,
      default: () => {
        return {
          type: 'pad',
          contains: 'padding',
          autosize: true
        }
      }
    },
    width: {
      default: null
    },
    height: {
      default: null
    },
    padding: {
      default: null
    },
    background: {
      default: null
    },
    hover: {
      default: 'hover'
    }
  },
  data: () => {
    return {
      view: {}
    }
  },
  mounted: function() {
    this.view = this.createView(this.spec);
  },
  beforeDestroy: function() {
    if(this.view) {
      this.view.finalize()
      this.view = null
    }
  },
  watch: {
    spec: {
      handler: function() {
        this.view = this.createView(this.spec);
      },
      deep: true
    }
  },
  methods: {
    createView: function(spec) {
      debugger;
      if(spec) {
        const runtime = vega.parse(spec);
        const view = new vega.View(runtime);
        ['renderer', 'padding', 'width', 'height', 'padding', 'background', 'hover'].forEach( (setting) => {
          if(this[setting]) {
            try {
              view[setting](this[setting])
            } catch(e) {

            }
          }
        })
        
        view.initialize(this.$el);

        view.run();

        select(this.$el).select('svg')
          .style('width', '100%')
          .style('height', '100%')

        return view;
      }
    }
  }
}
</script>
