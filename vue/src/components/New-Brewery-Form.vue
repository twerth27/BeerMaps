<template>
    <div>
        <b-form id="breweryForm">
          <b-form-group
            id="breweryName"
            label="Enter Name of Brewery:"
            label-for="name"
          >
          <b-form-input
            id="name"
            v-model="brewery.breweryName"
            type= "text"
            placeholder= "Brewery Name..."
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
            placeholder= "Brewery Description..."
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

            <b-button v-on:click="addNewBrewery" variant="primary" id="breweryFormSubmit" type="submit">Submit Brewery</b-button>

        </b-form>
    </div>
</template>

<script>
import breweryService from "../services/BreweryService";
export default({
    setup() {
        
    },
    data() {
      return{
        brewery: {
          breweryName: '',
          description: '',
          hasOutDoorSeating: false,
          hasFood: false,
          hasOnSiteBrewing: false,
          isPetFriendly: false
        } 
      }
    },
      
    name: "new-brewery-form",

  methods: {
      addNewBrewery(){
        breweryService.addBrewery(this.brewery).then(response => {
          if(response.status == 201){
            alert("Brewery successfully added");
          }
        })
            .catch(error => {
              console.log(error)
              alert("Brewery was not added")
            })
      }
  }
})
</script>

<style scoped>
div {
  padding: 10px;
}
</style>
