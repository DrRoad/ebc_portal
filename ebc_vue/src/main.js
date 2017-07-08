import Vue from 'vue'
import VueRouter from 'vue-router'
import App from './App.vue'
import Router from './router.js'

Vue.use(VueRouter)

new Vue({
  el: '#app',
  render: function(h) {return h(App)},
  router: Router
})