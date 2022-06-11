<template>
  <div>
    <h1 id="add">Add new Beer</h1>
    <add-beer-form></add-beer-form>
  </div>
</template>

<script>
import AddBeerForm from '../components/Add-Beer-Form.vue';


export default {
  name: "addBeer",
  components: {
    AddBeerForm,

  }
};
</script>

<style scoped>
div {
  font-family: tangerine;
  font-style: italic;
}

#add {
  padding-left: 25px;
}

</style>