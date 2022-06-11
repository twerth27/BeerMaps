<template>
<div id="beverage-list-container">

  <b-alert v-model="displayAlert" variant="success" dismissible>
    Successfully Deleted!
  </b-alert>

  <b-alert v-model="displayAddAlert" variant="success" dismissible>
    Successfully Added!
  </b-alert>

  <b-table :items="beverages" :fields="fields" striped responsive="sm" class="table-rows">
    <template #cell(details_and_options)="row">
      <b-button size="sm" @click="row.toggleDetails" class="mr-2">
        {{ row.detailsShowing ? 'Hide' : 'Show'}} Details and Options
      </b-button>
    </template>

    <template #row-details="row">
      <b-card class="detail-card">
        <b-row class="mb-2">
          <b-col sm="3" class="text-sm-right"><b>Available:</b></b-col>
          <b-col>{{ row.item.available }}</b-col>
        </b-row>

        <b-row class="mb-2">
          <b-col sm="3" class="text-sm-right"><b>Description:</b></b-col>
          <b-col>{{ row.item.description }}</b-col>
        </b-row>

        <b-modal ref="confirm-delete"
                 hide-footer centered
                 title="Are you sure?"
        >
          <div class="d-block text-center">
            <h3>Are you sure you want to delete this beverage globally?</h3>
            <h4>This cannot be undone.</h4>
          </div>
          <div class="popup-buttons">
            <b-button class="mt-3" variant="outline-danger" block  @click="deleteBeverageGlobally(row.item.beverageId)">Delete Beverage</b-button>
            <b-button class="mt-3" variant="outline-warning" block @click="exitDeleteConfirmation">Cancel</b-button>
          </div>
        </b-modal>

        <b-modal ref="confirm-add"
                 hide-footer centered
                 title="Are you sure?"
        >
          <div class="d-block text-center">
            <h3>Are you sure you want to add this beverage to your menu?</h3>
          </div>
          <div class="popup-buttons">
            <b-button class="mt-3" variant="outline-success" block  @click="addBeverageToMenu(row.item.beverageId)">Add Beverage</b-button>
            <b-button class="mt-3" variant="outline-danger" block @click="exitAddConfirmation">Cancel</b-button>
          </div>
        </b-modal>

        <div id="add-delete-hide">
          <b-button size="sm" @click="row.toggleDetails">Hide Details</b-button>
          <b-button v-show="isUserAdmin" size ="sm" variant ="danger" id="delete-button" @click="confirmDelete">Delete</b-button>
          <b-button v-show="isUserAdmin" size ="sm" variant ="outline-success" id="add-button" @click="confirmAdd">Add to Brewery Menu</b-button>
        </div>

      </b-card>
    </template>
  </b-table>

</div>
</template>

<script>
import BeverageService from "../services/BeverageService";
export default {
  name: "ViewGlobalBeverages",
  data(){
    return {
      fields: ['beverageName', 'beverageType', 'abv', 'ibu', 'details_and_options'],
      beverages: [],
      displayAlert: false,
      displayAddAlert: false
    }
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
  created(){
    this.loadAllBeverages();
  },
  methods: {
    loadAllBeverages(){
      BeverageService.getbeverages().then(response => {
        this.beverages = response.data;
      })
    },
    deleteBeverageGlobally(beverageId){
      BeverageService.deleteBeverageGloballyById(beverageId);
      this.exitDeleteConfirmation();
      this.displayAlert = true;
    },
    addBeverageToMenu(beverageId){
      BeverageService.addBeverageToMenu(beverageId);
      this.exitAddConfirmation();
      this.displayAddAlert = true;
    },
    confirmDelete(){
      this.$refs['confirm-delete'].show()
    },
    exitDeleteConfirmation() {
      this.$refs['confirm-delete'].hide()
    },
    confirmAdd(){
      this.$refs['confirm-add'].show()
    },
    exitAddConfirmation() {
      this.$refs['confirm-add'].hide()
    }
  }
}
</script>

<style scoped>

.table-rows{
  font-size: large;
  font-weight: bold;
  background-image: linear-gradient( #eb9630, #7e7676);
}

.set-text{
  color: white;
}

#add-delete-hide{
  display: flex;
  justify-content: space-evenly;
}

.detail-card {
  background-color: rgb(128, 128, 128, .33);
}

.popup-buttons{
  display: flex;
  justify-content: space-evenly;
}

</style>