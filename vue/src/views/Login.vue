<template>
  <div id="login" class="login-div">

    <video autoplay muted loop id="myVideo">
      <source src="../../public/BeerPour.mp4" type="video/mp4">
    </video>

    <form class="form-signin" @submit.prevent="login">
<!--      <h1 class="login-header">Welcome To BeerMaps</h1>-->
      <img id="logo" src="../../public/BEER MAPS.png" />
      <h2 class="login-quote">Find your next destination today!</h2>
      <h2 class="login-header-2">Please Sign In</h2>
      <div
        class="alert alert-danger"
        role="alert"
        v-if="invalidCredentials"
      >Invalid username and password!</div>
      <div
        class="alert alert-success"
        role="alert"
        v-if="this.$route.query.registration"
      >Thank you for registering, please sign in.</div>
      <label for="username" class="sr-only">Username</label>
      <input
        type="text"
        id="username"
        class="form-control-login"
        placeholder="Username"
        v-model="user.username"
        required
        autofocus
      />
      <label for="password" class="sr-only">Password</label>
      <input
        type="password"
        id="password"
        class="form-control-login"
        placeholder="Password"
        v-model="user.password"
        required
      />
      <router-link class="need-an-account" :to="{ name: 'register' }">Need an account?</router-link>
      <b-button id="sign-in-button" type="submit">Sign in</b-button>
    </form>
  </div>
</template>

<script>
import authService from "../services/AuthService";
export default {
  name: "login",
  components: {
  },
  data() {
    return {
      user: {
        username: "",
        password: ""
      },
      invalidCredentials: false
    };
  },
  methods: {
    login() {
      authService
        .login(this.user)
        .then(response => {
          if (response.status == 200) {
            this.$store.commit("SET_AUTH_TOKEN", response.data.token);
            this.$store.commit("SET_USER", response.data.user);
            this.$store.commit("GET_AUTHORITIES", response.data.user);
            this.$router.push("/");
          }
        })
        .catch(error => {
          const response = error.response;

          if (response.status === 401) {
            this.invalidCredentials = true;
          }
        });
    }
  }
};
</script>

<style scoped>

.form-control-login {
  display: flex;
  align-items: center;
  justify-content: center;
  padding-left: 5px;
  padding-right: 0px;
  margin-left: 37%;
}

#login {
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1;
  position: relative;
  
}

.login-header {
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 60px;
  margin-top: 0%;
  padding-bottom: 0px;
  color: rgb(255, 255, 255);
  font-family:Impact, Haettenschweiler, 'Arial Narrow Bold', sans-serif;
  
}

.login-quote {
  display: flex;
  align-items: center;
  justify-content: center;
  color:  aliceblue;
}

.login-header-2 {
  display: flex;
  align-items: center;
  justify-content: center;
  padding-top: 20px;
  color:  aliceblue;
}

label.sr-only {
  display: flex;
  align-items: center;
  /*justify-content: center;*/
  margin-left: 37%;
  color:  aliceblue;
}

.need-an-account {
  display: flex;
  align-items: center;
  justify-content: center;
  text-decoration: none;
  color: orange;
}
.need-an-account:hover {
  text-decoration: underline;
}

#sign-in-button {
  display: flex;
  align-items: center;
  justify-content: center;
  padding-left: 50px;
  padding-right: 50px;
  margin-left: 40%;
  background-color: orange;
  color: black;
}

#sign-in-button{
  margin-top: 10px;
}

/*#myVideo {*/
/*  position: fixed;*/
/*  right: 0;*/
/*  bottom: 0;*/
/*  min-width: 100%;*/
/*  min-height: 100%;*/
/*}*/

#logo{
  padding: -500px;
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

.login-div {
  margin-top: 15%;
  font-family: tangerine;
  font-style: italic;
  background-color: transparent;
}

</style>




