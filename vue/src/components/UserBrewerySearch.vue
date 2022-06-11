<template>
<div id="filter-container" class="full-table">
  <b-container id="filter-input" fluid>
    <b-row>
      <b-col sm="2">
        <label>Brewery Name:</label>
      </b-col>
      <b-col sm="4">
        <b-form-input  :state="resultState" v-model="breweryName"></b-form-input>
      </b-col>
    </b-row>
    <b-row id="checkbox-row">
      <b-col>
        <b-form-checkbox v-model="hasFood">Has Food</b-form-checkbox>
      </b-col>
      <b-col>
        <b-form-checkbox v-model="hasOnSiteBrewing">On Site Brewing</b-form-checkbox>
      </b-col>
      <b-col>
        <b-form-checkbox v-model="hasOutDoorSeating">Out Door Seating</b-form-checkbox>
      </b-col>
      <b-col>
        <b-form-checkbox v-model="petFriendly">Pet Friendly</b-form-checkbox>
      </b-col>
    </b-row>
  </b-container>

  <b-pagination
  align="center" 
  size="lg"
  id="pagination"
  v-model="currentPage"
  :total-rows="rowsLength"
  :per-page="perPage"
  aria-controls="search-table"
  pills
  class="custom-pagination"
  ></b-pagination>

  <b-table :per-page="perPage" :current-page="currentPage" :items="filteredList" :fields="fields" striped responsive="sm" id="search-table" class="table-rows">
    <template #cell(show_details)="row">
      <b-button size="sm" @click="row.toggleDetails" class="mr-2">
        {{ row.detailsShowing ? 'Hide' : 'Show'}} Details
      </b-button>
    </template>

    <template #row-details="row" >
      <b-card class="detail-card">
        <b-row class="mb-2">
          <b-col sm="3" class="text-sm-right"><b>Address: </b></b-col>
          <b-col>{{getAddressByAddressId(row.item.addressId)}}</b-col>
        </b-row>

        <b-row class="mb-2">
          <b-col sm="3" class="text-sm-right"><b>Phone Number: </b></b-col>
          <b-col>{{row.item.phoneNumber}}</b-col>
        </b-row>

        <b-row class="mb-2">
          <b-col sm="3" class="text-sm-right"><b>Hours of Operation:</b></b-col>
          <b-col>{{row.item.hours}}</b-col>
        </b-row>

        <b-row class="mb-2">
          <b-col sm="3" class="text-sm-right"><b>Some sort of brewery Imagery?</b></b-col>
          <b-col>There will be some lovely photos here - maybe - possibly.</b-col>
        </b-row>

        <b-row class="mb-2">
          <b-col sm="3" class="text-sm-right"><b>Latitude: </b></b-col>
          <b-col>{{row.item.latitude}}</b-col>
        </b-row>

        <b-row class="mb-2">
          <b-col sm="3" class="text-sm-right"><b>Longitude: </b></b-col>
          <b-col>{{row.item.longitude}}</b-col>
        </b-row>
        <div class="detail-option-buttons">
          <b-button size="sm" @click="row.toggleDetails">Hide Details</b-button>

          <b-button size ="sm" id="view-menu" @click="showBreweryMenu(row.item.breweryId)">View Offerings</b-button>

          <b-button size ="sm" id="view-ratings" @click="showBreweryRatings(row.item.breweryId)">Ratings</b-button>
        </div>

      </b-card>
    </template>
  </b-table>

  <b-modal id="menu-popup"
           v-model="showMenu"
           title="Current Offerings"
           hide-footer centered
           size="xl"
  >
  <beverage-list-by-brewery-id></beverage-list-by-brewery-id>
    <div class="finish-button-container">
      <b-button class="mt-3" variant="outline-danger"  @click="showMenu = false">Finish</b-button>
    </div>
  </b-modal>

  <b-modal id="ratings-popup"
           v-model="showRatings"
           title="Ratings"
           hide-footer centered
           size="xl"
  >
  <view-brewery-ratings></view-brewery-ratings>
    <div class="finish-button-container">
      <b-button class="mt-2 finish-button" variant ="outline-success" id="leave-rating-button" @click="leaveAReview" >Leave A Review</b-button>
      <b-button class="mt-2 finish-button" variant="outline-danger" @click="showRatings = false">Finish</b-button>
    </div>
  </b-modal>

  <b-modal id="leave-rating-popup"
           v-model="leaveRating"
           title="Leave A Rating"
           hide-footer centered
           size="xl"
  >
    <leave-a-brewery-rating-form></leave-a-brewery-rating-form>
    <div class="finish-button-container">
      <b-button class="mt-3 finish-button" variant="outline-danger"  @click="leaveRating = false">Exit</b-button>
    </div>
  </b-modal>

</div>
</template>

<script>
import BreweryService from "../services/BreweryService";
import BeverageListByBreweryId from "./BeverageListByBreweryId";
import ViewBreweryRatings from "./ViewBreweryRatings";
import LeaveABreweryRatingForm from "./LeaveABreweryRatingForm";
export default {
  name: "UserBrewerySearch",
  components: {
    BeverageListByBreweryId,
    ViewBreweryRatings,
    LeaveABreweryRatingForm
  },
  data() {
    return {
      breweries: [],
      fields: ['breweryName', 'hasOnSiteBrewing', 'hasOutDoorSeating', 'hasFood', 'petFriendly', 'description', 'show_details'],
      showMenu: false,
      showRatings: false,
      leaveRating: false,
      breweryName: '',
      hasFood: '',
      petFriendly: '',
      hasOutDoorSeating: '',
      hasOnSiteBrewing: '',
      currentPage: 1,
      perPage: 5
    };
  },
  computed: {
    rowsLength() {
      return this.filteredList.length;
    },

    filteredList(){
      let filteredBreweries = this.breweries;
      if (this.breweryName != ""){
        filteredBreweries = filteredBreweries.filter((brewery) =>
            brewery.breweryName
            .toLowerCase()
            .includes(this.breweryName.toLowerCase())
        );
      }
      if (this.hasFood === true){
        filteredBreweries = filteredBreweries.filter((brewery) =>
            brewery.hasFood === true
        );
      }
      if (this.petFriendly === true){
        filteredBreweries = filteredBreweries.filter((brewery) =>
            brewery.petFriendly === true
        );
      }
      if (this.hasOutDoorSeating === true){
        filteredBreweries = filteredBreweries.filter((brewery) =>
            brewery.hasOutDoorSeating === true
        );
      }
      if (this.hasOnSiteBrewing === true){
        filteredBreweries = filteredBreweries.filter((brewery) =>
            brewery.hasOnSiteBrewing === true
        );
      }
      return filteredBreweries;
    },
    resultState(){
      if(this.breweryName === ''){
        return null;
      } else return this.filteredList.length > 0;
    }
  },
  watch: {
    breweryName(value) {
      console.log(value);
       this.updateStoreBreweryList();
    },
    hasFood(value) {
      console.log(value);
       this.updateStoreBreweryList();
    },
    petFriendly(value) {
      console.log(value);
       this.updateStoreBreweryList();
    },
    hasOutDoorSeating(value) {
      console.log(value);
       this.updateStoreBreweryList();
    },
    hasOnSiteBrewing(value) {
      console.log(value);
       this.updateStoreBreweryList();
    }
  },
  methods: {
    loadAllBreweries() {
      BreweryService.getBreweries().then(response => {
        this.breweries = response.data;
      })
    },
    showBreweryMenu(breweryId){
      this.$store.commit('SET_SELECTED_MENU', breweryId);
      this.showMenu = true;
    },
    showBreweryRatings(breweryId){
      this.$store.commit('SET_SELECTED_BREWERY_RATINGS', breweryId);
      this.showRatings = true;
    },
    updateStoreBreweryList(){
      this.$store.commit('LIST_OF_BREWERIES', this.filteredList);
    },
    getAddressByAddressId(addressId){
      let correctAddress = this.$store.state.addressList.filter((address) =>
          address.addressId === addressId
      );
      return correctAddress[0].address;
    },
    leaveAReview(){
      this.showRatings = false;
      this.leaveRating = true;
    },
    convertFromBoolean(value){
      if(value === true){
        return 'Yes'
      } else {
        return'No'
      }
    }
  },
  created() {
    this.loadAllBreweries();
  }

}
</script>

<style scoped>

#filter-input{
  border: 1px solid black;
  padding: 10px;
  border-bottom-left-radius: 0px;
  border-bottom-right-radius: 0px;
  margin-top: 20px;
  background-image: linear-gradient(to top left, rgb(83, 77, 77), rgb(235, 150, 48));
  border-radius: 25px;
  font-size: medium;
  font-weight: bold;
  }

#checkbox-row{
  margin-top: 5px;
}

.finish-button-container{
  display: flex;
  justify-content: end;
  border-radius: 0px;
}

#leave-rating-button{
  margin-right: 100px;
}

.finish-button{
  margin-right: 20px;
}

.detail-option-buttons{
  display: flex;
  justify-content: space-evenly;
}

.table-rows {
  font-size: large;
  font-weight: bold;
 background-image: linear-gradient(to bottom right, #534d4d, #eb9630);
 border-radius: 25px;
}

.detail-card {
  background-color: rgb(128, 128, 128, .33);
}

#view-ratings {
  background-color: #FFCA4B;
  color: black;
  padding-right: 50px;
  padding-left: 50px;
}

#view-menu {
  background-color: orange;
  color: black;
  padding-right: 50px;
  padding-left: 50px;
}

#pagination {
  padding-top: 13px;
}

::v-deep .custom-pagination ::v-deep li ::v-deep a  {
  background-color: green;
}

#filter-container{
  border-bottom-left-radius: 25px;
  border-bottom-right-radius: 25px;
  font-family: tangerine;
  font-style: italic;
  font-weight: bold;

}
.filter-container > b-table{
    font-weight: bolder !important;
    font-size: 20px !important;
    z-index: 100 !important;
}

  
</style>