import axios from 'axios';


export default {

    getUserById(userId) {
        return axios.get(`/rating/username/${userId}`)
    },

    getUserByUsername(username){
        return axios.get(`/user/get/${username}`)
    },

    getAllUsernames(){
        return axios.get('/user/get/all')
    }
}