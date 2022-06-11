import axios from 'axios';


export default {
    getBreweries() {
        return axios.get('/brewery/all')
    },

    addBrewery(brewery) {
        return axios.post('/brewery/add', brewery)
    },

    registerBrewer(breweryId, brewerId) {
        return axios.put(`/brewery/update/${breweryId}/${brewerId}`)
    },

    updateBrewery(brewery){
      return axios.put('brewery/update', brewery)
    },

    deleteBrewery(id) {
        return axios.delete('/brewery', id)
    },

    getBreweryById(breweryId) {
        return axios.get(`/brewery/${breweryId}`)
    },

    getBreweryByBrewerId(brewerId){
        return axios.get(`/brewery/brewer/${brewerId}`)
    }


}