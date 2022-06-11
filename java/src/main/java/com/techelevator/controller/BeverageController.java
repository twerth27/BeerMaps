package com.techelevator.controller;

import com.techelevator.dao.BeverageDao;
import com.techelevator.dao.BreweryDao;
import com.techelevator.dao.UserDao;
import com.techelevator.model.Beverage;
import com.techelevator.model.User;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

//Authorization
@CrossOrigin
@RequestMapping(value = "/beverage")
@RestController
public class BeverageController {

    private BeverageDao beverageDao;
    private UserDao userDao;
    private BreweryDao breweryDao;

    public BeverageController(BeverageDao beverageDao, UserDao userDao, BreweryDao breweryDao) {
        this.beverageDao = beverageDao;
        this.userDao = userDao;
        this.breweryDao = breweryDao;
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_BREWER')")
    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(path = "/add", method = RequestMethod.POST)
    public boolean addBeverage(@RequestBody Beverage beverage) {
        return beverageDao.addBeverageGlobally(beverage);
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_BREWER')")
    @ResponseStatus(HttpStatus.ACCEPTED)
    @RequestMapping(path = "/brewery/add/{beverageId}", method = RequestMethod.POST)
    public boolean addBeverageToBrewery(@PathVariable int beverageId, Principal principal) {
        return beverageDao.addBeverageToBrewery(beverageId, principal);
    }

    @ResponseStatus(HttpStatus.ACCEPTED)
    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_BREWER','ROLE_USER')")
    @RequestMapping(path = "/all", method = RequestMethod.GET)
    public List<Beverage> getAllBeverages(){
        return beverageDao.listAll();
    }

    @ResponseStatus(HttpStatus.ACCEPTED)
    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_BREWER')")
    @RequestMapping(path="/delete/{beverageId}", method = RequestMethod.DELETE)
    public boolean deleteBeverageFromBrewery(@PathVariable int beverageId) {
        return beverageDao.deleteBeverageFromBrewery(beverageId);
    }

    @ResponseStatus(HttpStatus.ACCEPTED)
    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_BREWER')")
    @RequestMapping(path="/delete/global/{beverageId}", method = RequestMethod.DELETE)
    public boolean deleteBeverageGlobally(@PathVariable int beverageId) {
        return beverageDao.deleteBeverageGlobally(beverageId);
    }

    @ResponseStatus(HttpStatus.ACCEPTED)
    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_BREWER')")
    @RequestMapping(path="/update", method = RequestMethod.PUT)
    public boolean updateBeverage(@RequestBody Beverage beverage) {
        return beverageDao.updateBeverage(beverage);
    }

    @ResponseStatus(HttpStatus.ACCEPTED)
    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_BREWER','ROLE_USER')")
    @RequestMapping(path = "/{beverageId}", method = RequestMethod.GET)
    public Beverage getBeverageById(@PathVariable int beverageId) {
        return beverageDao.getBeverageById(beverageId);
    }

    @ResponseStatus(HttpStatus.ACCEPTED)
    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_BREWER','ROLE_USER')")
    @RequestMapping(path = "/name/{name}", method = RequestMethod.GET)
    public Beverage getBeverageByName(@PathVariable String name) {
        return beverageDao.getBeverageByName(name);
    }

    @ResponseStatus(HttpStatus.ACCEPTED)
    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_BREWER','ROLE_USER')")
    @RequestMapping(path = "/brewery/{breweryId}")
    public List<Beverage> getAllBeveragesByBreweryId(@PathVariable int breweryId) {
        return beverageDao.listAllBeveragesByBreweryId(breweryId);
    }
}
