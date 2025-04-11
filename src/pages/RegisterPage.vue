<template>
  <div class="min-h-screen flex items-center justify-center bg-gray-100 p-4">
    <div class="w-full max-w-md bg-white p-6 rounded-xl shadow">
      <h2 class="text-2xl font-bold mb-4 text-center">Create Account</h2>
      <form @submit.prevent="handleSubmit" class="space-y-4">
        <input
          type="email"
          v-model="email"
          placeholder="Email address"
          class="w-full border p-2 rounded"
          required
        />
        <input
          type="password"
          v-model="password"
          placeholder="Password"
          class="w-full border p-2 rounded"
          required
        />
        <button
          type="submit"
          class="w-full bg-blue-500 text-white p-2 rounded hover:bg-blue-600"
        >
          Sign Up
        </button>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
// Import necessary modules for reactive state
import { ref } from 'vue';

// Define reactive variables for form inputs
const email = ref('');
const password = ref('');

// Handle form submission
const handleSubmit = () => {
  console.log('Email:', email.value);
  console.log('Password:', password.value);
  // You can add logic here to handle form submission to your server
};
</script>

<style scoped>
/* If needed, you can add styles here */
</style>
