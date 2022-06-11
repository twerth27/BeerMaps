<template>
  <div id="review-container">
    <b-table :items="filteredList" :fields="fields" striped responsive="sm" class="table-rows">
      <template #cell(show_details)="row">
        <b-button size="sm" @click="row.toggleDetails" class="mr-2">
          {{ row.detailsShowing ? 'Hide' : 'Show'}} Details
        </b-button>
      </template>
      <template #row-details="row">
        <b-card class="detail-card">

          <b-row class="mb-2">
            <b-col sm="3" class="text-sm-right"><b>User: </b></b-col>
            <b-col>{{getNameFromId(row.item.reviewerId)}}</b-col>
          </b-row>

          <b-row class="mb-2">
            <b-col sm="3" class="text-sm-right"><b>Review: </b></b-col>
            <b-col>{{row.item.ratingText}}</b-col>
          </b-row>

          <b-button size="sm" @click="row.toggleDetails">Hide Details</b-button>
        </b-card>
      </template>
    </b-table>
  </div>
</template>

<script>
import RatingService from "../services/RatingService";

export default {
  name: "ViewBeverageRatings",
  data() {
    return {
      ratings: [],
      fields: ['rating', 'date', 'show_details'],
      filter: {
        rating: '',
        ratingDate: ''
      },
    };
  },
  computed: {
    filteredList() {
      let filteredRatings = this.ratings;
      return filteredRatings;
    }
  },
  created() {
    this.loadBreweryRatings();
  },
  methods: {
    loadBreweryRatings() {
      RatingService.getBeverageRatingsById(this.$store.state.selectedBeverageRating).then(response => {
        this.ratings = response.data
      })
    },
    getNameFromId(reviewerId) {
      let correctUser = this.$store.state.usernameList.filter((username) =>
          username.userId === reviewerId
      );
      return correctUser[0].username;
    }
  }
}
</script>

<style scoped>

.detail-card {
  background-color: rgb(128, 128, 128, .33);
}

.table-rows{
  background-image: linear-gradient(to top left, #534d4d, #eb9630);
}

</style>