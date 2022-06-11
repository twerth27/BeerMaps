import axios from 'axios';


export default {

    getBreweryRatingsById(breweryId) {
        return axios.get(`/rating/all/brewery/${breweryId}`)
    },

    getBeverageRatingsById(beverageId) {
        return axios.get(`/rating/all/beverage/${beverageId}`)
    },

    addRating(rating){
        return axios.post('/rating/add', rating)
    }
}