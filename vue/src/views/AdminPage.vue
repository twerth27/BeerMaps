<template>
  <div id="page-container">

    <video autoplay muted loop id="myVideo">
      <source src="../../public/Foam.mp4" type="video/mp4">
    </video>
    <brewery-card id="brew"></brewery-card>
    <admin-beverage-list id="bev-list"></admin-beverage-list>
    <average-rating-display id="average-rating"></average-rating-display>
  </div>
</template>

<script>
import BreweryCard from '../components/BreweryCard';
import AdminBeverageList from "../components/AdminBeverageList";
import RatingService from "../services/RatingService";
import AverageRatingDisplay from "../components/AverageRatingDisplay";
export default {
  components: {
    BreweryCard,
    AdminBeverageList,
    AverageRatingDisplay
  },
  name: "AdminPage",
  created(){
    this.populateRatings()
  },
  computed: {
    getBreweryId(){
      return this.$store.state.breweryIdFromBrewer
    }
  },
  methods: {
    populateRatings() {
      RatingService.getBreweryRatingsById(this.getBreweryId).then((response) => {
      this.$store.commit('SET_CURRENT_USERS_BREWERY_RATINGS', response.data)
    })
    }
  },
};
</script>

<style scoped>

#brew{
  grid-area: brewery;
  border: 1px solid black;
  padding-top: 10px;
  background-color: #eb9630;
  border-radius: 25px;
  opacity: .9;
}

#average-rating{
  grid-area: rating;
}


#bev-list{
  grid-area: bevlist;
  border: 1px solid black;
  padding: 1px;
  border-radius: 25px;
  font-family: tangerine;
  font-style: italic;
  font-size: x-large;
  font-weight: bolder;
  background-image: linear-gradient( #534d4d, #eb9630);
  color: black;
  opacity: .9;
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


#page-container{
  margin-top: 100px;
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
  margin-left: 3%;
  margin-right: 3%;
  z-index: 1;
  position: relative;
  
  grid-template-areas:
  "brewery brewery rating rating rating"
  "brewery brewery rating rating rating"
   ". . rating rating rating"
   "bevlist bevlist bevlist bevlist bevlist"
  ;
  gap: 10px;
}

</style>
