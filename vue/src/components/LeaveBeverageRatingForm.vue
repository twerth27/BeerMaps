<template>
  <div>
    <b-form id="leave-rating-form">

      <b-alert v-model="addedSuccess" variant="success" dismissible>
        Successfully Added!
      </b-alert>

      <b-form-rating id="rating-number" v-model="rating.rating" variant="primary"></b-form-rating>

      <b-form-group
          id="review-body"
          label="Tell us what you think"
          label-for="rating-text"
      >
        <b-form-textarea
            id="rating-text"
            v-model="rating.ratingText"
            type= "text-area"
            placeholder= "Leave a Review"
        ></b-form-textarea>
        <b-button id="submit-rating" class="mt-3" @click="leaveRating">Submit</b-button>
      </b-form-group>
    </b-form>
  </div>
</template>

<script>
import RatingService from "../services/RatingService";
export default {
  name: "LeaveBeverageRatingForm",
  data() {
    return {
      rating: {
        ratingText: '',
        rating: 3,
        type: 'beverage',
        id: '',
        reviewerId: '',
        date: ''
      },
      addedSuccess: false
    };
  },
  computed: {
    getUserID() {
      return this.$store.state.user.id
    },
    getBeverageId(){
      return this.$store.state.selectedBeverageRating
    }
  },
  created() {
    this.setRatingAttributes();
  },
  methods: {
    setRatingAttributes(){
      let today = new Date().toISOString().slice(0, 10);
      this.rating.date = today;
      this.rating.reviewerId = this.getUserID;
      this.rating.id = this.getBeverageId;
    },
    leaveRating(){
      console.log(this.rating)
      RatingService.addRating(this.rating).then((response) => {
        if(response.status == 201){
          this.addedSuccess = true;
        }
      })
          .catch(error => {
            console.log(error)
            alert("Rating Not Added")
          })
    }
  }
}
</script>

<style scoped>
#submit-rating{
  margin-left: 25px;
  padding-left: 35px;
  padding-right: 35px;
  background-color: #eb9630;
  color: black;
}
#leave-rating-form{
  font-size: large;
  font-weight: bold;
  background-image: linear-gradient( #eb9630, #7e7676);
}
</style>