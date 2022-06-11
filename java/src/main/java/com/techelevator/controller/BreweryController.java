package com.techelevator.controller;

import com.techelevator.dao.BeverageDao;
import com.techelevator.dao.BreweryDao;
import com.techelevator.dao.UserDao;
import com.techelevator.model.Brewery;
import com.techelevator.model.User;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.annotation.security.PermitAll;
import java.security.Principal;
import java.util.List;

@CrossOrigin
@RestController
@RequestMapping(value = "/brewery")
public class BreweryController {

    private BreweryDao breweryDao;
    private UserDao userDao;
    private BeverageDao beverageDao;

    public BreweryController(BreweryDao breweryDao, UserDao userDao, BeverageDao beverageDao){
        this.beverageDao = beverageDao;
        this.userDao = userDao;
        this.breweryDao = breweryDao;
    }
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(path = "/add", method = RequestMethod.POST)
    public boolean addBrewery(@RequestBody Brewery brewery, Principal principal) {
        return breweryDao.addBrewery(brewery, principal);
    }

//    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_USER', 'ROLE_BREWER')")
    @ResponseStatus(HttpStatus.ACCEPTED)
    @RequestMapping(path = "/all", method = RequestMethod.GET)
    public List<Brewery> getAllBreweries() {
        return  breweryDao.listAll();
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_USER', 'ROLE_BREWER')")
    @ResponseStatus(HttpStatus.ACCEPTED)
    @RequestMapping(path = "/{breweryId}", method = RequestMethod.GET)
    public Brewery getBreweryById(@PathVariable int breweryId) {
        return breweryDao.getBreweryById(breweryId);
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_BREWER')")
    @ResponseStatus(HttpStatus.ACCEPTED)
    @RequestMapping(path = "/brewer/{brewerId}", method = RequestMethod.GET)
    public Brewery getBreweryByBrewerId(@PathVariable int brewerId) {
        return breweryDao.getBreweryByBrewerId(brewerId);
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_USER', 'ROLE_BREWER')")
    @ResponseStatus(HttpStatus.ACCEPTED)
    @RequestMapping(path = "/name/{name}", method = RequestMethod.GET)
    public Brewery getBreweryByName(@PathVariable String name) {
        return breweryDao.getBreweryByName(name);
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @ResponseStatus(HttpStatus.ACCEPTED)
    @RequestMapping(path = "/delete/{breweryId}", method = RequestMethod.DELETE)
    public boolean deleteBrewery(@PathVariable int breweryId) {
        return breweryDao.deleteBrewery(breweryId);
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_BREWER')")
    @ResponseStatus(HttpStatus.ACCEPTED)
    @RequestMapping(path = "/update", method = RequestMethod.PUT)
    public boolean updateBrewery(@RequestBody Brewery brewery) {
        return breweryDao.updateBrewery(brewery);
    }

    @PreAuthorize("permitAll()")
    @ResponseStatus(HttpStatus.ACCEPTED)
    @RequestMapping(path = "/update/{breweryId}/{brewerId}", method = RequestMethod.PUT)
    public boolean updateBreweryRegister(@PathVariable int breweryId, @PathVariable int brewerId) {
        return breweryDao.registerBrewer(breweryId, brewerId);
    }
}
