<template>
  <router-view :fulldata="fulldata" :profordata="profordata"></router-view>
</template>

<script>

export default {
  props: ["fulldata", "profordata"],
  beforeRouteEnter (to, from, next) {
    next(vm => vm.$emit("minimizeBanner", true))
  },
  beforeRouteLeave (to, from, next) {
    this.$emit("minimizeBanner", false)
    next()
  }
}
</script>