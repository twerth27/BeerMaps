import axios from 'axios';


export default {

    getAllAddresses() {
        return axios.get('/address/all')
    }
}