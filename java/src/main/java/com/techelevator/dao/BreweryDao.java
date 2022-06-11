package com.techelevator.dao;

import com.techelevator.model.Brewery;

import java.security.Principal;
import java.util.List;

public interface BreweryDao {

    List<Brewery> listAll();

    Brewery getBreweryById(int breweryId);

    Brewery getBreweryByName(String name);

    boolean addBrewery(Brewery brewery, Principal principal);

    boolean deleteBrewery(int breweryId);

    boolean updateBrewery(Brewery brewery);

    boolean registerBrewer(int breweryId, int brewerId);

    Brewery getBreweryByBrewerId(int brewerId);
}
