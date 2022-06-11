<template>
<div id="footer-container">
  <img src="../../public/Beer-Mug.png" />

  <div class="team-info">
    <p>Created By: The Brew-Tang Clan &copy;</p>
    <p>Members: Luke Bartley, Justin Hulett, Jose Rubino, Ben Weddle, Tyler Werth</p>
  </div>

  <div class="social-column">
    <img src="../../public/social-media-icons.png" class="social-icons"/>
    <h4>(Coming Soon!)</h4>
  </div>

  <img src="../../public/Beer-Mug.png" class="flip-image"/>
  

</div>

</template>

<script>
export default {
  name: "AppFooter"
}
</script>

<style scoped>
#footer-container {
  background-image: linear-gradient(to bottom right, rgb(41, 41, 41), rgb(112, 112, 112));
  z-index: 100;
  display: flex;
  justify-content: space-between;
  font-weight: bold;
  font-size: x-large;
  color: black;
  padding: 30px;
  
  
}

.flip-image {
  -webkit-transform: scaleX(-1);
  transform: scaleX(-1);
}
.team-info {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border-left: 1px solid black;
  border-right: 1px solid black;
  padding-top: 10px;
  padding-left: 20px;
  padding-bottom: 10px;
  padding-right: 20px;
  margin: 25px;
}
.social-column {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.social-icons {
  
  height: 150px;
}
</style>