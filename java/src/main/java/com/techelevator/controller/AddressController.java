package com.techelevator.controller;

import com.techelevator.dao.AddressDao;
import com.techelevator.dao.BreweryDao;
import com.techelevator.dao.UserDao;
import com.techelevator.model.Address;
import com.techelevator.model.Beverage;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RequestMapping(value = "/address")
@RestController
public class AddressController {

    private AddressDao addressDao;
    private BreweryDao breweryDao;
    private UserDao userDao;

    public AddressController(AddressDao addressDao, BreweryDao breweryDao, UserDao userDao) {
        this.addressDao = addressDao;
        this.breweryDao = breweryDao;
        this.userDao = userDao;
    }

    @ResponseStatus(HttpStatus.ACCEPTED)
    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_BREWER','ROLE_USER')")
    @RequestMapping(path = "/{addressId}", method = RequestMethod.GET)
    public Address getAddressById(@PathVariable int addressId){
        return addressDao.getAddressById(addressId);
    }

    @ResponseStatus(HttpStatus.ACCEPTED)
    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_BREWER','ROLE_USER')")
    @RequestMapping(path = "/all", method = RequestMethod.GET)
    public List<Address> getAllAddresses(){
        return addressDao.getAllAddresses();
    }

    @ResponseStatus(HttpStatus.ACCEPTED)
    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_BREWER')")
    @RequestMapping(path="/update", method = RequestMethod.PUT)
    public boolean updateAddress(@RequestBody Address address) {
        return addressDao.updateAddress(address);
    }


}
