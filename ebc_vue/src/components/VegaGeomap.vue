<template>
  <Vega v-if="spec !== null" :spec="spec"></Vega>
</template>

<script>
import Vega from './Vega.vue'

export default {
  components: {
    Vega
  },
  props: ["spec"]
}
</script>
