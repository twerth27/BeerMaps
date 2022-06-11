<template>
  <div id="add-beverage-div">
    <b-form id="NewbeverageForm">
      <b-form-group
          id="beverageName"
          label="Enter Name of beverage:"
          label-for="name"
      >
        <b-form-input
            id="name"
            v-model="beverage.beverageName"
            type= "text"
            :placeholder= "beverage.beverageName"
            required
        ></b-form-input>
      </b-form-group>

      <b-form-group
          id="beverageDescription"
          label="Enter a description of the beverage"
          label-for="description"
      >
        <b-form-textarea
            id="description"
            v-model="beverage.description"
            type= "text-area"
            :placeholder= "beverage.description"
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
            :placeholder= "beverage.abv"
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
            :placeholder= "beverage.ibu"
            required
        ></b-form-input>
      </b-form-group>

      <b-form-group
          id="url"
          label="Type the URL to link an Image: "
          label-for="url"
      >
        <b-form-input
            id="url"
            v-model="beverage.imageUrl"
            type= "number"
            :placeholder= "beverage.imageUrl"
            required
        ></b-form-input>
      </b-form-group>
      <div id="check-and-option">
        <b-form-group
            id="type"
            label="Enter the type of beverage: "
            label-for="type"
        >
          <b-form-select v-model="beverage.beverageType" :options="options"></b-form-select>
        </b-form-group>
        <b-form-checkbox
            id="availability"
            v-model="beverage.available"
            name="availability"
            :value=true
            :unchecked-value=false
            size="lg"
        >Check if product is currently available</b-form-checkbox>
      </div>

      <b-button variant="primary" v-on:click.prevent="updateBeverage" id="beverageUpdateubmit" type="submit">Update Beverage</b-button>

    </b-form>
  </div>
</template>

<script>
import BeverageService from "../services/BeverageService";
export default {
  name: "UpdateBeverageForm",
  data() {
    return{
      beverage: {
        beverageName: '',
        description: '',
        abv: 0,
        ibu: 0,
        beverageType: '',
        imageUrl: '',
        available: true
      },
      options: [
        { value: null, text: 'Please select an option' },
        { value: 'Beer', text: 'Beer' },
        { value: 'IPA', text: 'IPA' },
        { value: 'Cider', text: 'Cider' },
        { value: 'Wine', text: 'Wine' },
        { value: 'NA', text: 'N/A Beverage'}
      ]
    }
},
  computed: {
    getBeverageId(){
      return this.$store.state.selectedBeverageToUpdate
    }
  },
  created(){
    BeverageService.getBeverageByBeverageId(this.getBeverageId).then(response => {
      this.beverage = response.data
    })
  },
  methods: {
    updateBeverage(){
      console.log(this.beverage)
      BeverageService.updateBeverage(this.beverage).then(response => {
        if(response.status == 202){
          alert("Beverage Updated");
        }
      })
          .catch(error => {
            console.log(error)
            alert("Beverage Not Updated")
          })
    }
  }
}
</script>

<style scoped>

</style>