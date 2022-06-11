<template>
  <div class="home">

    <welcome-message id="message"></welcome-message>

    <AddGoogleMap id="map"></AddGoogleMap>

    <UserBrewerySearch id="brewery-search"></UserBrewerySearch>

    <div class="spacer">
    </div>
   
   <about-section id="about-section"></about-section>

  </div>
  
</template>

<script>
import AddGoogleMap from "../components/Map-feature.vue"
import WelcomeMessage from "../components/Welcome-Message.vue"
import BreweryService from "../services/BreweryService";
import UserBrewerySearch from "../components/UserBrewerySearch";
import AddressService from "../services/AddressService";
import UserService from "../services/UserService";
import AboutSection from "../components/About-Section.vue"
export default {
  name: "home",
  components: {
    AddGoogleMap,
    WelcomeMessage,
    UserBrewerySearch,
    AboutSection
  },
  data(){
    return {
      listOfBreweries: [],
    }
  },
  methods: {
    getAllBreweriesAddToStore(){
      BreweryService.getBreweries().then(response => {
        this.$store.commit("LIST_OF_BREWERIES", response.data)
      }).catch(error => {
        alert(error + "There was an error getting breweries")
      })
    },
    setStoreBreweryId(){
      BreweryService.getBreweryByBrewerId(this.getBrewerID).then(response => {
        this.$store.commit('SET_BREWERY_ID_FROM_BREWER', response.data.breweryId)
      })
    },
    setStoreAddressList(){
      AddressService.getAllAddresses().then(response => {
        this.$store.commit('SET_ADDRESS_LIST', response.data);
      })
    },
    setUsernameList(){
      UserService.getAllUsernames().then(response => {
        this.$store.commit('SET_USERNAME_LIST', response.data)
      })
    }
  },
  created() {
    this.getAllBreweriesAddToStore();
    this.setStoreBreweryId();
    this.setStoreAddressList();
    this.setUsernameList();
  },
  computed: {
    getBrewerID() {
      return this.$store.state.user.id
    }
  }
  
};
</script>

<style scoped>

#message {
  grid-area: message;
  display: flex;
    border: solid black 1px;
    border-top-right-radius: 25px;
    border-top-left-radius: 25px;
    padding: 5px;
    background-image: linear-gradient( #534d4d, #eb9630);
    align-items: center;
    justify-content: center;
    font-family: tangerine;
    font-style: italic;
}

#map {
  grid-area: map;
}

#brewery-search {
  grid-area: search;
  /* opacity: .9; */
  /* overflow: auto;
  max-height: 60%; */
}

#about-section {
  grid-area: about-section;
  margin-top: -200px;
  padding: 25px;
  grid-row-start: row1-start;
  align-self: start;
  
}

.top-photos {
  height: 200px;
  width: 500px;
  grid-area: t-photo;

}

#bottom-photo{
  display: flex;
  grid-area: b-photo;
  opacity: .6;
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

#bottom-filler-photo {
  margin-top: 20%;
  border-radius: 50%;
  width: 25em;
  max-height: 20em;
}

.spacer {
  height: 200px;
  
}

.home {
  display: grid;
  margin-top: 100px;
  grid-template-columns: 1fr 1fr 1fr 1fr 1fr 1fr;
  grid-template-rows: 50px 3fr 1fr 2fr;
  gap: 25px;
  margin-left: 3%;
  margin-right: 3%;
  z-index: 1;
  position: relative;
  
  grid-template-areas: 
  "message message message message message message"
  "map map map search search search"
  "about-section about-section about-section search search search"
  ". . . search search search"
  ;
}
</style>
