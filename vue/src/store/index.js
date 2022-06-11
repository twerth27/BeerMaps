import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

/*
 * The authorization header is set for axios when you login but what happens when you come back or
 * the page is refreshed. When that happens you need to check for the token in local storage and if it
 * exists you should set the header so that it will be attached to each request
 */
const currentToken = localStorage.getItem('token')
const currentUser = JSON.parse(localStorage.getItem('user'));


if(currentToken != null) {
  axios.defaults.headers.common['Authorization'] = `Bearer ${currentToken}`;
}

export default new Vuex.Store({
  state: {
    token: currentToken || '',
    user: currentUser || {},
    currentUserRole : '',
    breweryIdFromBrewer: 0,
    searchCity: '',
    listOfBreweries: [],
    selectedBreweryMenu: '',
    selectedBreweryRatings: '',
    selectedBeverageRating: '',
    selectedBeverageToUpdate: '',
    addressList: [],
    usernameList: [],
    loggedInBreweryRatings: []
  },
  mutations: {
    SET_AUTH_TOKEN(state, token) {
      state.token = token;
      localStorage.setItem('token', token);
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`
    },
    SET_USER(state, user) {
      state.user = user;
      localStorage.setItem('user',JSON.stringify(user));
    },
    LOGOUT(state) {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      state.token = '';
      state.user = {};
      state.currentUserRole = '';
      state.breweryIdFromBrewer = 0;
      axios.defaults.headers.common = {};
    },
    GET_AUTHORITIES(state, user){
      state.currentUserRole = user.authorities[0].name;
    },
    SET_BREWERY_ID_FROM_BREWER(state, breweryId){
      state.breweryIdFromBrewer = breweryId;
    },
    LIST_OF_BREWERIES(state, list){
      state.listOfBreweries = list;
    },
    SET_SELECTED_MENU(state, breweryId){
      state.selectedBreweryMenu = breweryId;
    },
    SET_SELECTED_BREWERY_RATINGS(state, breweryId){
      state.selectedBreweryRatings = breweryId;
    },
    SET_ADDRESS_LIST(state, list){
      state.addressList = list;
    },
    SET_USERNAME_LIST(state, list){
      state.usernameList = list;
    },
    SET_SELECTED_BEVERAGE_RATING(state, beverageId){
      state.selectedBeverageRating = beverageId;
    },
    SET_SELECTED_BEVERAGE_TO_UPDATE(state, beverageId){
      state.selectedBeverageToUpdate = beverageId;
    },
    SET_CURRENT_USERS_BREWERY_RATINGS(state, list){
      state.loggedInBreweryRatings = list;
    }
  }
})
