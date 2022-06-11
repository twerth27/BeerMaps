<template>
    <div id="brewery-map">

        <label>
      </label>
          <div class="filter">
            <h4>Please select a location:</h4>
            <gmap-autocomplete @place_changed="initMarker"></gmap-autocomplete>
            <button @click="addLocationMarker">Add</button>
            <br />
          </div>
        
        <gmap-map
            :zoom="11"
            :center="center"
            style= "width:100%; height: 600px;"
        >
          <gmap-info-window :options="infoOptions" :position="infoWindowPos" :opened="infoWinOpen" @closeclick="infoWinOpen=false"></gmap-info-window>
          <gmap-info-window :options="iconInfoOptions" :position="this.center" :opened="iconInfoWinOpen" @closeclick="iconInfoWinOpen=false"></gmap-info-window>

           <gmap-marker
               :key="index"
               v-for="(m,index) in this.dropPinsForBreweries"
               :position="m.position"
               :clickable="true"
               @click="toggleInfoWindow(m,index)"
           ></gmap-marker>

           <!-- Adds you are here star and info window -->

            <gmap-marker
            :position="this.center"
            :icon= youAreHereIcon
            :clickable="true"
             @click="toggleIconWindow"
            ></gmap-marker>

        </gmap-map>
    </div>
</template>

<script>
import starIcon from '../assets/starIcon-small.png'
export default({
    setup() {},
    name: 'map-area',
    data() {
        return {
            center: {
                lat: 39.983334,
                lng: -82.983330,
                // current coordinates for Columbus OH
            },
            locationMarkers: [],
            locPlaces: [],
            existingPlace: null,
            infoWindowPos: null,
            infoWinOpen: false,
            currentMidx: null,
            infoOptions: {
            content: '',
            //optional: offset infowindow so it visually sits nicely on top of our marker
            pixelOffset: {
              width: 0,
              height: -35
            }
          },
          youAreHereIcon: starIcon,
          iconInfoWinOpen: false,
          iconInfoOptions: {
              content: 'You Are Here',
          }

        };
    },
  methods: {
    initMarker(loc) {
      this.existingPlace = loc;
    },
    addLocationMarker() {
      if (this.existingPlace) {
        const marker = {
          lat: this.existingPlace.geometry.location.lat(),
          lng: this.existingPlace.geometry.location.lng()
        }
        this.locationMarkers.push({position: marker})
        this.locPlaces.push(this.existingPlace)
        this.center = marker
        this.existingPlace = null
      }
    },
    toggleInfoWindow(marker, idx) {

      this.infoWindowPos = marker.position;
      this.infoOptions.content = marker.infoText;

      //check if its the same marker that was selected if yes toggle
      if (this.currentMidx == idx) {
        this.infoWinOpen = !this.infoWinOpen;
      }
      //if different marker set infowindow to open and reset current marker index
      else {
        this.infoWinOpen = true;
        this.currentMidx = idx;
      }
    },
    toggleIconWindow(){
      this.iconInfoWinOpen = !this.iconInfoWinOpen;
    }
  },
    computed: {
      storeListOfBreweries() {
        return this.$store.state.listOfBreweries
      },
      dropPinsForBreweries() {
        let locations = []
        this.storeListOfBreweries.forEach((brewery) =>  {
          const marker = {
            lat: brewery.latitude,
            lng: brewery.longitude
          }
            locations.push(
                {
                  position: marker,
                  infoText: '<h4>' + `${brewery.breweryName}` + '</h4>' +
                      '<h6> Phone Number: ' + `${brewery.phoneNumber}` + '</h6>'
                  + '<h6> Latitude: '+ `${brewery.latitude}`+'</h6>'
                      + '<h6> Longitude: '+ `${brewery.longitude}`+'</h6>'
                })
        })
        return locations;
      }
    }
})

</script>

<style scoped>

#brewery-map {
/* background-image: linear-gradient(to top right, rgb(247, 223, 195), rgb(255, 145, 0)); */
} 

.filter {
 display: flex;
 align-items: center;
 justify-content: flex-end;
 padding: 5px;
 padding-right: 40px;
 background-color: #eb9630;
 opacity: .8;
 font-size: large;
 font-weight: bold;
 border-top-left-radius: 25px;
 border-top-right-radius: 25px;

}

h4 {
  padding-right: 10px;
  font-size: larger;
  font-family: tangerine;
  font-style: italic;
  
}
</style>
