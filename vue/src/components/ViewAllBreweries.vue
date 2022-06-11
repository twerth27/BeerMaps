<template>

  <div id="brewery-card-container">
    <brewery-card-list v-bind:breweries="breweries"></brewery-card-list>
  </div>

</template>

<script>
import BreweryService from "../services/BreweryService";
import BreweryCardList from "./BreweryCardList";

export default {
  name: "ViewAllBreweries",
  components: {
    BreweryCardList
  },
  data(){
    return{
      breweries:[]
    };
  },
  created(){
    this.loadAllBreweries();
  },
  methods: {
    loadAllBreweries(){
      BreweryService.getBreweries().then(response => {
        this.breweries = response.data
      })
    }
  }
}
</script>

<style scoped>

</style>