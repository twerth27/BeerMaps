<template>
  <div id="app">
    <div :id="vertical">
      <nav-top-bar id="nav-bar" v-show="!isLoginPage"></nav-top-bar>
      <div id="content">
        <router-view/>
      </div>
     <app-footer v-show="!isLoginPage" class="footer"></app-footer>
    </div>
  </div>
</template>
<script>

import NavTopBar from "@/components/Nav-Top-Bar.vue";
import AppFooter from "./components/AppFooter";

export default ({
  components: {
    NavTopBar,
    AppFooter
  },
  computed: {
    isLoginPage(){
      return this.$route.name === 'login' || this.$route.name === 'register'
    },
    vertical(){
      if (this.isLoginPage === true){
        return ""
      }
      else {
        return "vertical"
      }
      }
    }
})
</script>


<style>

html {
  font-family: tangerine;
  font-style: italic;
  background-color: rgb(89, 94, 94);
}

.footer {
  background-color: red;
  height: 200px;
}

#app {
  background-color: rgb(89, 94, 94);
  background-image: url("../public/TapStill.jpg");
  background-attachment: fixed;
  background-size: cover;
}



#vertical{
  display: grid;
  gap: 10px;
}

</style>
