<template>
    <div id="add-beverage-div">
        <b-form id="NewbeverageForm">
          <b-form-group
            id="beverageName"
            label="Enter Name of Beverage:"
            label-for="name"
          >
          <b-form-input
            id="name"
            v-model="beverage.beverageName"
            type= "text"
            placeholder= "Beverage Name..."
            required
          ></b-form-input>
          </b-form-group>

          <b-form-group
            id="beverageDescription"
            label="Enter a description of the Beverage"
            label-for="description"
          >
          <b-form-textarea
            id="description"
            v-model="beverage.description"
            type= "text-area"
            placeholder= "Beverage Description..."
          ></b-form-textarea>
          </b-form-group>

          <b-form-group
            id="abv"
            label="Enter the alcohol by volume(ABV) amount: "
            label-for="abv"
          >
          <b-form-input
            id="abv"
            v-model="beverage.abv"
            type= "number"
            placeholder= "0.0"
            required
          ></b-form-input>
          </b-form-group>

          <b-form-group
            id="ibu"
            label="Enter the International Bitterness Units(IBU) amount: "
            label-for="ibu"
          >
          <b-form-input
            id="ibu"
            v-model="beverage.ibu"
            type= "number"
            placeholder= "IBU #"
            required
          ></b-form-input>
          </b-form-group>
          <div id="check-and-option">
            <b-form-group
                id="type"
                label="Enter the type of Beverage: "
                label-for="type"
            >
              <b-form-select v-model="beverage.beverageType" :options="options"></b-form-select>
            </b-form-group>
            <b-form-checkbox
                id="availability"
                v-model="beverage.available"
                name="availability"
                value="true"
                unchecked-value="false"
                size="lg"
            >Check if product is currently available</b-form-checkbox>
          </div>

            <b-button class="button" v-on:click.prevent="addNewbeverage" id="beverageFormSubmit" type="submit">Add Beverage</b-button>

        </b-form>
    </div>
</template>

<script>
import beverageService from '../services/BeverageService'
export default({
    setup() {
        
    },
    data() {
      return {
        beverage: {
          beverageName: '',
          description: '',
          abv: 0,
          ibu: 0,
          beverageType: '',
          imageUrl: 'none',
          available: false
        },
        options: [
          { value: null, text: 'Please select an option' },
          { value: 'Beer', text: 'Beer' },
          { value: 'Cider', text: 'Cider' },
          { value: 'Wine', text: 'Wine' },
          { value: 'NA', text: 'N/A Beverage'}
        ]
      }
    },

    name: "add-beverage-form",
    
    methods: {
      addNewbeverage() {
      beverageService.addbeverage(this.beverage).then(response => {
        if(response.status == 201) {
          alert("beverage successfully added");
          }
        })
        .catch(error => {
          console.log(error)
          alert("beverage was not added")
        })
      }
    }
});




</script>

<style scoped>
div {
  padding: 10px;
}
#check-and-option{
  display: flex;
  align-items: center;
  justify-content: center;
}

#beverageFormSubmit{
  margin-top: 10px;
}

.button {
  background-color: #eb9630;
  color: black;
}

</style>
