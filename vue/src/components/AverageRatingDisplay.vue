<template>
  <div>
    <h2 id="title">Average Brewery Rating</h2>
    <b-form-rating v-model="averageRating" readonly></b-form-rating>

    <div id="rating-container">
      <b-table :items="ratings" :fields="fields" striped responsive="sm">
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

  </div>
</template>

<script>
export default {
  name: "AverageRatingDisplay",
  data() {
    return {
      ratings: [],
      fields: ['rating', 'date', 'show_details']
    }
  },
  computed: {
    averageRating(){
      let ratings = this.$store.state.loggedInBreweryRatings
      let sum = 0;
      ratings.forEach((entry) => {
        sum += entry.rating
      })
      return sum / (ratings.length)
    }
  },
  created(){
    this.ratings = this.$store.state.loggedInBreweryRatings
  },
  methods: {
    getNameFromId(reviewerId){
      let correctUser = this.$store.state.usernameList.filter((username) =>
          username.userId === reviewerId
      );
      return correctUser[0].username;
    }
  }

}
</script>

<style scoped>

#rating-container{
  background-color: #eb9630;
  opacity: .9;
}

.detail-card {
  background-color: rgb(128, 128, 128, .33);
  opacity: .9;
}

#title{
  text-align: center;
}

</style>