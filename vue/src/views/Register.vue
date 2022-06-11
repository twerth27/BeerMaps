<template>
  <div id="register" class="text-center">

    <video autoplay muted loop id="myVideo">
      <source src="../../public/BubbleMug.mp4" type="video/mp4">
    </video>

    <form class="form-register" @submit.prevent="register">
      <img id="logo" src="../../public/BEER MAPS.png" />
      <h1 class="register-header">Create Account</h1>
      <div class="alert alert-danger" role="alert" v-if="registrationErrors">
        {{ registrationErrorMsg }}
      </div>
      <div class="row">
        <label for="username" class="sr-only">Username</label>
        <input
        type="text"
        id="username"
        class="form-control-register"
        placeholder="Username"
        v-model="user.username"
        required
        autofocus
        />
      </div>
      <div class="row">
      <label for="password" class="sr-only">Password</label>
        <input
          type="password"
          id="password"
          class="form-control-register"
          placeholder="Password"
          v-model="user.password"
          required
        />
        <input
          type="password"
          id="confirmPassword"
          class="form-control-register"
          placeholder="Confirm Password"
          v-model="user.confirmPassword"
          required
        />
      </div>
      
        <input
        v-on:change="changeBrewerMethod"
        type="checkbox"
        id="brewerCheckbox"
        class="brewer-checkbox"/>
        <label for="brewerCheckbox" class="brewer-checkbox">Are you a brewer?</label>
      <div class="row">
        <b-form-group
          class="select-group"
          label="Select your Brewery"
          v-if="this.user.role === 'brewer'"
        >
          <b-form-select
              id="brewery-select"
              v-model="selected"
              :options="brewerySelectOptions"
              class="mb-3"
              value-field="value"
              text-field="text"
              disabled-field="notEnabled"
          ></b-form-select>
        </b-form-group>
        </div>
        
      <div class="row">
        <b-button id="create-account-button" class="create-account-button" type="submit">Create Account</b-button>
        <router-link class="have-account-link" :to="{ name: 'login' }">Have an account?</router-link>
      </div>
    </form>
  </div>
</template>

<script>
import authService from '../services/AuthService';
import BreweryService from "../services/BreweryService";
import UserService from "../services/UserService";
export default {
  name: 'register',
  data() {
    return {
      user: {
        username: '',
        password: '',
        confirmPassword: '',
        role: 'user',
      },
      registrationErrors: false,
      registrationErrorMsg: 'There were problems registering this user.',
      selected: 0,
      breweries: [],
      currentUser: {},
      registerSuccess: false
    };
  },
  computed: {
    brewerySelectOptions(){
      let returnOptions = []
      this.breweries.forEach((brewery) => {
        const selectObject = {
          value: brewery.breweryId,
          text: brewery.breweryName
        }
        returnOptions.push(selectObject);
      })
      return returnOptions;
    }
  },
  watch: {
    registerSuccess(value){
      console.log(value)
      this.getUsername();
    },
    currentUser(value){
      console.log(value)
      this.updateBrewer();
    }
  },
  methods: {
    register() {
      if (this.user.password != this.user.confirmPassword) {
        this.registrationErrors = true;
        this.registrationErrorMsg = 'Password & Confirm Password do not match.';
      } 
      else {
        authService
          .register(this.user)
          .then((response) => {
            if (response.status == 201) {

              if(this.user.role === 'brewer'){
                this.registerSuccess = true;
              }

              if(this.user.role === 'user'){
                this.$router.push({
                  path: '/login',
                  query: { registration: 'success' }
                });
              }
            }
          })
          .catch((error) => {
            const response = error.response;
            this.registrationErrors = true;
            if (response.status === 400) {
              this.registrationErrorMsg = 'Bad Request: Validation Errors';
            }
          });
      }
    },
    getUsername(){
      UserService.getUserByUsername(this.user.username).then(response => {
        this.currentUser = response.data
      })
    },
    updateBrewer(){
      console.log(this.selected)
      BreweryService.registerBrewer(this.selected, this.currentUser.userId).then(() =>{
              this.$router.push({
                path: '/login',
                query: {registration: 'success'}
              });
      })
    },
    changeBrewerMethod() {
      if (this.user.role === "user") {
        this.user.role = "brewer"
      } else if (this.user.role === "brewer") {
        this.user.role = "user"
      }
    },
    clearErrors() {
      this.registrationErrors = false;
      this.registrationErrorMsg = 'There were problems registering this user.';
    },
    getAllBreweries(){
      BreweryService.getBreweries().then(response =>
          this.breweries = response.data
      )}
  },
  created(){
    this.getAllBreweries();
  }
};
</script>

<style scoped>
.register-header{
  font-size: 50px;
  margin-top: 0%;
  color: aliceblue;
  font-family:Impact, Haettenschweiler, 'Arial Narrow Bold', sans-serif;
}

#register {
  z-index: 1;
  position: relative;
}

.form-control-register {
  display: flex;
  flex-direction: column;
}

.create-account-button {
  background-color: orange;
  color: black;
}

.have-account-link {
  text-decoration: none;
  color: orange;
  font-size: 24px;
}
.have-account-link:hover {
  text-decoration: underline;
}

#myVideo {
  width: 100vw;
  height: 100vh;
  object-fit: cover;
  position: fixed;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
  z-index: -1;
}

.sr-only {
  color: aliceblue;
}

.form-register {
  margin-top: 10%;
  justify-content: center;
  align-items: center;
}

.row {
  display: flex;
  flex-direction: column;
  gap: 5px;
  margin-left:45%;
  margin-right: 45%;
  padding: 10px;
}
.brewer-checkbox {
  color: aliceblue;
  padding: 10px;
}
.select-group {
  color: aliceblue;
  margin-left: -10%;
}

</style>
