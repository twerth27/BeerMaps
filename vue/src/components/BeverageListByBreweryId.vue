<template>
<div id="beverage-menu">

  <b-table :items="beverages" :fields="fields" striped responsive="sm" class="table-rows">
    <template #cell(leave_review)="row">
      <b-button size="sm" @click="loadBeverageRating(row.item.beverageId)">
       Leave Review
      </b-button>
    </template>

    <template #cell(view_reviews)="row">
      <b-button size="sm" @click="loadBeverageReviews(row.item.beverageId)">
        View Reviews
      </b-button>
    </template>
  </b-table>

  <b-modal id="beverage-ratings-popup"
           v-model="showBeverageRating"
           title="Ratings"
           hide-footer centered
           size="xl"
  >
    <leave-beverage-rating-form></leave-beverage-rating-form>
    <div class="finish-button-container">
      <b-button class="mt-2 finish-button" variant="outline-danger" @click="showBeverageRating = false">Finish</b-button>
    </div>
  </b-modal>

  <b-modal id="beverage-reviews-popup"
           v-model="showReviews"
           title="All Reviews"
           hide-footer centered
           size="xl"
  >
    <view-beverage-ratings></view-beverage-ratings>
    <div class="finish-button-container">
      <b-button class="mt-2 finish-button" variant="outline-danger" @click="showReviews = false">Finish</b-button>
    </div>
  </b-modal>

</div>
</template>

<script>
import BeverageService from "../services/BeverageService";
import LeaveBeverageRatingForm from "./LeaveBeverageRatingForm";
import ViewBeverageRatings from "./ViewBeverageRatings";
export default {
  name: "BeverageListByBreweryId",
  components: {
    LeaveBeverageRatingForm,
    ViewBeverageRatings
  },
  data(){
    return {
      fields: ['beverageName', 'beverageType', 'abv', 'ibu', 'description', 'leave_review', 'view_reviews'],
      beverages: [],
      showBeverageRating: false,
      showReviews: false
    };
  },
  created(){
    this.loadAllBeverages();
  },
  methods: {
    loadAllBeverages() {
      BeverageService.getBeveragesByBreweryId(this.$store.state.selectedBreweryMenu).then(response => {
        this.beverages = response.data;
      })
    },
    loadBeverageRating(beverageId){
      this.showBeverageRating = true
      this.$store.commit('SET_SELECTED_BEVERAGE_RATING',beverageId)
    },
    loadBeverageReviews(beverageId){
      this.showReviews = true;
      this.$store.commit('SET_SELECTED_BEVERAGE_RATING',beverageId)
    }
  }
}
</script>

<style scoped>
.finish-button-container{
  display: flex;
  justify-content: end;
  border-radius: 0px;
}

.table-rows{
  font-size: large;
  font-weight: bold;
  background-image: linear-gradient( #eb9630, #7e7676);
}

.finish-button{
  margin-right: 20px;
}

</style>