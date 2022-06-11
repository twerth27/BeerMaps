<template>
  <div>
    <b-form id="updateForm">
      <b-alert v-model="displayUpdateAlert" variant="success" dismissible>
        Successfully Updated!
      </b-alert>
      <b-form-group
          id="breweryName"
          label="Enter Name of Brewery:"
          label-for="name"
      >
        <b-form-input
            id="name"
            v-model="brewery.breweryName"
            type= "text"
            :placeholder= "brewery.breweryName"
            required
        ></b-form-input>
      </b-form-group>
      <b-form-group
          id="breweryHours"
          label="Enter Hours of Operation:"
          label-for="hours"
      >
      <b-form-input
          id="hours"
          v-model="brewery.hours"
          type= "text"
          :placeholder="brewery.hours"
          required
      ></b-form-input>
      </b-form-group>

      <b-form-group
          id="breweryDescription"
          label="Enter a description of the brewery"
          label-for="description"
      >
        <b-form-textarea
            id="description"
            v-model="brewery.description"
            type= "text-area"
            :placeholder= "brewery.description"
        ></b-form-textarea>
      </b-form-group>

      <b-form-checkbox
          id="outdoorSeating"
          v-model="brewery.hasOutDoorSeating"
          name="checkbox-1"
          value="true"
          unchecked-value="false"
      >Does it have outdoor seating?</b-form-checkbox>

      <b-form-checkbox
          id="allowsPets"
          v-model="brewery.isPetFriendly"
          name="allowsPets"
          value="true"
          unchecked-value="false"
      >Does it allow pets?</b-form-checkbox>

      <b-form-checkbox
          id="hasFood"
          v-model="brewery.hasFood"
          name="hasFood"
          value="true"
          unchecked-value="false"
      >Does it serve food?</b-form-checkbox>

      <b-form-checkbox
          id="onsiteBrewing"
          v-model="brewery.hasOnSiteBrewing"
          name="onsiteBrewing"
          value="true"
          unchecked-value="false"
      >Does it have onsite brewing?</b-form-checkbox>

      <b-button v-on:click.prevent="updateBrewery" variant="primary" id="updateSubmit" type="submit">Update Brewery</b-button>
    </b-form>
  </div>
</template>

<script>
import BreweryService from "../services/BreweryService";

export default {
  name: "UpdateBreweryForm",
  data() {
    return{
      brewery: {
        breweryName: '',
        description: '',
        hours: '',
        hasOutDoorSeating: false,
        hasFood: false,
        hasOnSiteBrewing: false,
        isPetFriendly: false,
      },
      displayUpdateAlert: false
    }
  },
  computed: {
    getBrewerID() {
      return this.$store.state.user.id
    }
  },
  methods: {
    updateBrewery(){
      BreweryService.updateBrewery(this.brewery).then(response => {
        if(response.status == 202){
          this.displayUpdateAlert = true;
        }
      })
          .catch(error => {
            console.log(error)
            alert("Brewery Not Updated")
          })
    }
  },
  created() {
    BreweryService.getBreweryByBrewerId(this.getBrewerID).then(response => {
          this.brewery = response.data;
        }
    );
  }
}

</script>

<style scoped>

</style>