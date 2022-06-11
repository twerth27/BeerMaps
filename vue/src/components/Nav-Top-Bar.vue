<template>
    <div id="main-nav">
    <b-navbar toggleable="lg" id="navbar">
      
    <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

    <b-collapse id="nav-collapse" is-nav>
      <div class="left-side">
        <!-- home button -->
        <div class="home-icon">
          <router-link v-bind:to="{ name: 'home' }" id="home"><img src="../../public/logosmall.png" class="icon" /></router-link>
        </div>
      </div>
      <div class="middle">
          <img class="logo" src="../../public/BEER MAPS.png" />
        </div>

      <div class="right-side">
        <div class="buttons">
          <b-navbar-nav>
            <b-button v-if="this.isUserAdmin" class="nav-button" size="sm" @click="toAdmin">Admin Page</b-button>
          </b-navbar-nav>

          <b-navbar-nav id="showbevs">
              <b-button class="nav-button" size="sm" @click="showGlobalBeverages">View All Beverages</b-button>
          </b-navbar-nav>
        </div>

        <b-navbar-nav class="ml-auto">
          <b-nav-item-dropdown id="dropdown-right" right>
            <!-- Using 'button-content' slot -->
            <template id="testing" #button-content>
                <b-avatar variant="primary"></b-avatar>
            </template>
              <b-dropdown-item v-show="isUserAdmin" @click="showAddBeverage">Add a Beverage</b-dropdown-item>
              <b-dropdown-item @click="showGlobalBeverages">Manage Beverages</b-dropdown-item>
            <b-dropdown-item v-show="isUserAdmin" @click="showUpdateBrewery">Update Brewery</b-dropdown-item>
              <b-dropdown-item><router-link v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link></b-dropdown-item>
            </b-nav-item-dropdown>
        </b-navbar-nav>
      
      </div>
    </b-collapse>
  </b-navbar>

      <b-modal id="update-brewery"
               v-model="updateBrewery"
               title="Update Brewery Information"
               size="xl"
               hide-footer centered
      >
        <update-brewery-form></update-brewery-form>
        <div class="finish-button-container">
          <b-button class="mt-3 finish" variant="outline-danger"  @click="updateBrewery = false">Finish</b-button>
        </div>
      </b-modal>


        <b-modal id="global-beverage"
             v-model="showGlobal"
             title="All Our Beverages"
             size="xl"
             hide-footer centered
    >
        <view-global-beverages></view-global-beverages>
             <div class="finish-button-container">
        <b-button class="mt-3 finish" variant="outline-danger"  @click="showGlobal = false">Finish</b-button>
            </div>
        </b-modal>

        <b-modal id="add-beverage"
             v-model="showAdd"
             title="Add a New Beverage"
             hide-footer centered
    >
        <add-beer-form></add-beer-form>
            <div class="finish-button-container">
        <b-button class="mt-3 finish" variant="outline-danger"  @click="showAdd = false">Finish</b-button>
      </div>
    </b-modal>

    </div>
</template>

<script>
import ViewGlobalBeverages from "./ViewGlobalBeverages";
import AddBeerForm from "./Add-Beer-Form";
import updateBreweryForm from "./UpdateBreweryForm";
export default({
    name: "nav-top-bar",
    components: {
    ViewGlobalBeverages,
    AddBeerForm,
      updateBreweryForm
  },
  data(){
    return {
      showGlobal: false,
      showAdd: false,
      updateBrewery: false
    };
  },
  computed: {
    isUserAdmin() {
      if (this.$store.state.currentUserRole != 'ROLE_USER') {
        return true
      } 
      else
          return false
    }
  },
  methods: {
    showGlobalBeverages(){
      this.showGlobal = true;
    },
    showUpdateBrewery(){
      this.updateBrewery = true;
    },
    showAddBeverage(){
      this.showAdd = true;
    },
    toAdmin() {
      this.$router.push('/admin');
    }
  }
})

</script>

<style scoped>
#home {
    padding-right: 38%;
    padding-left: 30px;
    color: red;
}

#home:hover {
  color: green;
}

#navbar {
  background-image: linear-gradient(to bottom right, rgb(41, 41, 41), rgb(112, 112, 112));
}

#manage {
  display: flex;
  
}

.buttons {
  display: flex;
  gap: 5px;
  margin-right: 10%;
  
}

#nav-collapse{
  display: flex;
  justify-content: space-between;
  
}
.middle {
  margin-left: 200px;
}
.left-side {
  display: flex;
  align-items: center;
}
.right-side {
  display: flex;
  align-items: center;
  margin-right: 100px;
}
#navbar {
  width: 100%;
  height: 100px;
  position: fixed;
  z-index: 500;

}

 .logo {
   width: 300px;
 }

#admin-page-link {
  padding-right: 20px;
}

.icon {
  height: 30%;
  width: 30%;
}
.icon:hover {
  height: 40%;
  width: 40%;
  cursor: pointer;
}
.nav-button {
  background-color: orange;
  height: 50px;
  color: black;
}

.finish-button-container {
  display: flex;
  justify-content: flex-end;
}

</style>
