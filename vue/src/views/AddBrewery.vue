<template>
  <div>
    <h1 id="header">Add New Brewery</h1>
    <new-brewery-form></new-brewery-form>
  </div>
</template>

<script>
import NewBreweryForm from '../components/New-Brewery-Form.vue'

export default {
  name: "addBrewery",
  components: {
    NewBreweryForm,

  }
};
</script>

<style scoped>
#breweryForm{
    display: flex;
    flex-direction: column;
}

div {
  font-family: tangerine;
  font-style: italic;
}

#header {
  padding-left: 25px;
}

</style>
