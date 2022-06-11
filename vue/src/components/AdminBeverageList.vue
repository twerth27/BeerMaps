<template>
<div class="beverage-container">

  <b-alert v-model="displayAlert" variant="success" dismissible>
    Successfully Deleted!
  </b-alert>

  <b-table :items="beverages" :fields="fields" striped responsive="sm">
    <template #cell(show_details)="row">
      <b-button size="sm" @click="row.toggleDetails" class="mr-2">
        {{ row.detailsShowing ? 'Hide' : 'Show'}} Details
      </b-button>
    </template>

    <template #row-details="row">
      <b-card class="detail-card">
        <b-row class="mb-2">
          <b-col sm="3" class="text-sm-right"><b>Abv: </b></b-col>
          <b-col>{{ row.item.abv }}</b-col>
        </b-row>

        <b-row class="mb-2">
          <b-col sm="3" class="text-sm-right"><b>Available:</b></b-col>
          <b-col>{{ row.item.available }}</b-col>
        </b-row>

        <b-row class="mb-2">
          <b-col sm="3" class="text-sm-right"><b>IBUs:</b></b-col>
          <b-col>{{ row.item.ibu }}</b-col>
        </b-row>

        <b-row class="mb-2">
          <b-col sm="3" class="text-sm-right"><b>Description:</b></b-col>
          <b-col>{{ row.item.description }}</b-col>
        </b-row>

        <div class="hide-delete-update">
          <b-button class="hdu-button" size="sm" @click="row.toggleDetails">Hide Details</b-button>
          <b-button class="hdu-button" size ="sm" variant ="danger" id="delete-button" @click="confirmDelete">Delete</b-button>
          <b-button class="hdu-button" size ="sm" variant ="success" id="update-button" @click="setActiveBeverageToUpdate(row.item.beverageId)">Update</b-button>
        </div>

        <b-modal ref="confirm-delete"
                 hide-footer centered
                 title="Are you sure?"
        >
          <div class="d-block text-center">
            <h3>Are you sure you want to remove this beverage?</h3>
          </div>
          <div id="popup-buttons">
            <b-button class="mt-3" variant="outline-danger" block  @click="deleteBeverageById(row.item.beverageId)">Delete Beverage</b-button>
            <b-button class="mt-3" variant="outline-warning" block @click="exitDeleteConfirmation">Cancel</b-button>
          </div>
        </b-modal>

        <b-modal id="update-popup"
                 v-model="showUpdate"
                 title="Update Beverage"
                 hide-footer centered
                 size="xl"
        >
          <update-beverage-form></update-beverage-form>
          <div class="finish-button-container">
            <b-button class="mt-3 finish-button" variant="outline-danger"  @click="showUpdate = false">Exit</b-button>
          </div>
        </b-modal>

      </b-card>
    </template>
  </b-table>

</div>
</template>

<script>
import BeverageService from "../services/BeverageService";
import UpdateBeverageForm from "./UpdateBeverageForm";
export default {
  name: "AdminBeverageList",
  components: {
    UpdateBeverageForm
  },
  data() {
    return {
      fields: ['beverageName', 'beverageType', 'show_details'],
      beverages: [],
      displayAlert: false,
      showUpdate: false
    }
  },
  computed: {},
  created() {
    this.loadBeverages();
  },
  methods: {
    deleteBeverageById(beverageId) {
      BeverageService.deletebeverage(beverageId);
      this.exitDeleteConfirmation();
      this.displayAlert = true;
    },
    confirmDelete() {
      this.$refs['confirm-delete'].show()
    },
    exitDeleteConfirmation() {
      this.$refs['confirm-delete'].hide()
    },
    loadBeverages() {
      BeverageService.getBeveragesByBreweryId(this.$store.state.breweryIdFromBrewer).then(response => {
        this.beverages = response.data;
      })
    },
    setActiveBeverageToUpdate(beverageId){
      this.$store.commit('SET_SELECTED_BEVERAGE_TO_UPDATE', beverageId)
      this.showUpdate = true
    }
  }
}

</script>

<style scoped>

.detail-card {
  background-color: rgb(128, 128, 128, .33);
  opacity: .9;
}

.hdu-button{
  padding-left: 60px;
  padding-right: 60px;
}

.hide-delete-update{
  display: flex;
  justify-content: space-evenly;
}

#popup-buttons{
  display: flex;
  justify-content: space-evenly;
}

</style>