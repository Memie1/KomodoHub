

import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/Home.vue';
import RegisterPage from '../pages/RegisterPage.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/register',
    name: 'Register',
    component: RegisterPage
  },
  // Add more routes here
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;

