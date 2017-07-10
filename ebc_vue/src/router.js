import VueRouter from 'vue-router'
import Home from './components/Home.vue'
import About from './components/About.vue'
import AboutMethod from './components/AboutMethod.vue'
import AboutGroup from './components/AboutGroup.vue'
import AboutTool from './components/AboutTool.vue'
import Contact from './components/Contact.vue'

// 1. Define route components.
// These can be imported from other files
var Explore = { template: '<h4>explore</h4>' }
var News = { template: '<div>news</div>' }
var Research = { template: '<div>research</div>' }
var Register = { template: '<div>register</div>' }

// 2. Define some routes
// Each route should map to a component. The "component" can
// either be an actual component constructor created via
// `Vue.extend()`, or just a component options object.
// We'll talk about nested routes later.
var routes = [
  { path: '/', component: Home },
  { path: '/about', component: About,
      children: [
        {
          path: 'method',
          component: AboutMethod
        },
        {
          path: 'tool',
          component: AboutTool
        },
        {
          path: 'group',
          component: AboutGroup
        }
      ]
  },
  { path: '/explore', component: Explore/*,
      children: [
        {
          path: 'map',
          component: ExploreMap
        },
        {
          path: 'linkage',
          component: ExploreLinkage
        },
        {
          path: 'dashboard',
          component: ExploreDashboard
        }
      ]*/
  },
  { path: '/research', component: Research/*,
      children: [
        {
          path: 'ongoing',
          component: ResearchOngoing
        }
      ]*/
  },
  { path: '/news', component: News },
  { path: '/contact', component: Contact },
  { path: '/register', component: Register}
]

// 3. Create the router instance and pass the `routes` option
// You can pass in additional options here, but let's
// keep it simple for now.
var router = new VueRouter({
  routes: routes // short for `routes: routes`
})

export default router
