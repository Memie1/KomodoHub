<template>
  <div class="min-h-screen flex items-center justify-center bg-gray-100 p-4">
    <div class="w-full max-w-md bg-white p-6 rounded-xl shadow-lg">
      <h2 class="text-2xl font-bold mb-4 text-center text-green-700">Create Account</h2>

      <form @submit.prevent="handleSubmit" class="space-y-4">
        <!-- Email -->
        <input
          type="email"
          v-model="email"
          placeholder="Email address"
          class="w-full border border-gray-300 p-2 rounded focus:outline-none focus:ring focus:border-green-400"
          required
        />

        <!-- Password -->
        <input
          type="password"
          v-model="password"
          placeholder="Password"
          class="w-full border border-gray-300 p-2 rounded focus:outline-none focus:ring focus:border-green-400"
          @input="checkPasswordStrength"
          required
        />
        <p class="text-sm" :class="passwordStrengthClass">{{ passwordStrength }}</p>

        <!-- Confirm Password -->
        <input
          type="password"
          v-model="confirmPassword"
          placeholder="Confirm Password"
          class="w-full border border-gray-300 p-2 rounded focus:outline-none focus:ring focus:border-green-400"
          required
        />

        <!-- Role -->
        <select
          v-model="role"
          class="w-full border border-gray-300 p-2 rounded focus:outline-none focus:ring focus:border-green-400"
          required
        >
          <option disabled value="">Select Role</option>
          <option value="student">Student</option>
          <option value="teacher">Teacher</option>
          <option value="admin">School Administrator</option>
          <option value="community">Community Member</option>
        </select>

        <!-- Invite Code -->
        <input
          v-if="role === 'student' || role === 'teacher'"
          type="text"
          v-model="inviteCode"
          placeholder="Enter Access Code"
          class="w-full border border-gray-300 p-2 rounded focus:outline-none focus:ring focus:border-green-400"
          required
        />

        <!-- Privacy Policy Agreement -->
        <div class="flex items-center text-sm">
          <input type="checkbox" v-model="agreePolicy" class="mr-2" required />
          <label>
            I agree to the
            <a href="/privacy" class="underline text-blue-600 hover:text-blue-800" target="_blank">Privacy Policy</a>
          </label>
        </div>

        <!-- Submit Button -->
        <button
          type="submit"
          class="w-full bg-green-600 text-white p-2 rounded hover:bg-green-700 disabled:opacity-50"
          :disabled="!formValid"
        >
          Register
        </button>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router'

const router = useRouter()

const email = ref('')
const password = ref('')
const confirmPassword = ref('')
const role = ref('')
const inviteCode = ref('')
const agreePolicy = ref(false)

const passwordStrength = ref('')

function checkPasswordStrength() {
  const p = password.value
  if (p.length < 6) passwordStrength.value = 'Too short'
  else if (!/[A-Z]/.test(p) || !/[0-9]/.test(p)) passwordStrength.value = 'Weak'
  else if (/[A-Z]/.test(p) && /[0-9]/.test(p) && /[^A-Za-z0-9]/.test(p)) passwordStrength.value = 'Strong'
  else passwordStrength.value = 'Medium'
}

const passwordStrengthClass = computed(() => {
  switch (passwordStrength.value) {
    case 'Strong':
      return 'text-green-600'
    case 'Medium':
      return 'text-yellow-600'
    case 'Weak':
    case 'Too short':
      return 'text-red-600'
    default:
      return ''
  }
})

const formValid = computed(() => {
  return (
    email.value &&
    password.value &&
    confirmPassword.value === password.value &&
    role.value &&
    (role.value === 'student' || role.value === 'teacher' ? inviteCode.value : true) &&
    agreePolicy.value
  )
})

async function handleSubmit() {
  if (!formValid.value) {
    alert('Please complete the form correctly.')
    return
  }

  try {
    const response = await axios.post('http://localhost:5000/register', {
      username: email.value.split('@')[0], 
      email: email.value,
      password: password.value,
      role: role.value.toUpperCase(),     
      invite_code: inviteCode.value
    })

    alert('Registration successful!')
    console.log(response.data)

  
    router.push('/login')
  } catch (err: any) {
    console.error(err)
    alert(err?.response?.data?.error || 'Registration failed.')
  }
}
</script>

<style scoped>
.success {
  color: green;
}
.error {
  color: red;
}
</style>
