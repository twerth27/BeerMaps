<template>
  <div id="card-container">
    <h1 class="text-center">{{ beverage.beverageName }}</h1>
    <p>Description: {{ beverage.description }}</p>
    <p>What the hell am I drinking? {{ beverage.beverageType }}</p>
    <p>How much booze in that thing (ABV)? {{ beverage.abv }}</p>
    <p>How many IBU's are there? {{ beverage.ibu }}</p>
    <p>Do you have a picture? {{ beverage.imageUrl }}</p>
    <p>Can i buy it? {{ beverage.available }}</p>
    <p>Whats my Id? {{beverage.beverageId}}</p>
  </div>
</template>

<script>
import BeverageService from "../services/BeverageService";
export default {
  name: 'beverage-card',
  data() {
    return {
      beverage: {
        beverageId: 0,
        beverageName: '',
        description: '',
        abv: '',
        beverageType: '',
        ibu: '',
        imageUrl: '',
        available: ''
      }
    };
  },
  created() {
    BeverageService.getBeverageByBeverageId(2).then(response => {
          this.beverage = response.data;
        }
    );
  },
};
</script>


<style scoped>

</style>