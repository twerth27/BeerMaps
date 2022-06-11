package com.techelevator.dao;

import com.techelevator.model.Brewery;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
@Component
public class BreweryDaoJdbc implements BreweryDao{

    private JdbcTemplate jdbcTemplate;
    private JdbcUserDao userDao;

    public BreweryDaoJdbc(JdbcTemplate jdbcTemplate, JdbcUserDao userDao) {

        this.jdbcTemplate = jdbcTemplate;
        this.userDao = userDao;
    }

    @Override
    public List<Brewery> listAll() {
        List<Brewery> breweriesList = new ArrayList<>();
        String sql = "SELECT brewery.brewery_id, name, hours, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id, bai.address_id, phone_number, latitude, longitude " +
                "FROM brewery " +
                "JOIN brewery_address_info bai on brewery.brewery_id = bai.brewery_id " +
                "JOIN address_info ai on ai.address_id = bai.address_id";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
        while (results.next()){
            Brewery brewery = mapRowToBrewery(results);
            breweriesList.add(brewery);
        }
        return breweriesList;
    }

    @Override
    public Brewery getBreweryById(int breweryId) {
        Brewery brewery = null;
        String sql = "SELECT brewery.brewery_id, name, hours, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id, bai.address_id, phone_number, latitude, longitude " +
                " FROM brewery " +
                "JOIN brewery_address_info bai on brewery.brewery_id = bai.brewery_id " +
                "JOIN address_info ai on ai.address_id = bai.address_id " +
                "WHERE bai.brewery_id = ? ";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, breweryId);
        if(results.next()) {
            brewery = mapRowToBrewery(results);
        }
        return brewery;
    }

    @Override
    public Brewery getBreweryByBrewerId(int brewerId) {
        Brewery brewery = null;
        String sql = "SELECT brewery.brewery_id, name, hours, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id, bai.address_id, phone_number, latitude, longitude " +
                " FROM brewery " +
                "JOIN brewery_address_info bai on brewery.brewery_id = bai.brewery_id " +
                "JOIN address_info ai on ai.address_id = bai.address_id " +
                "WHERE brewer_id = ? ";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, brewerId);
        if(results.next()) {
            brewery = mapRowToBrewery(results);
        }
        return brewery;
    }

    @Override
    public Brewery getBreweryByName(String name) {
        Brewery brewery = null;
        String sql = "SELECT brewery.brewery_id, name, hours, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id, bai.address_id, phone_number, latitude, longitude " +
                " FROM brewery " +
                "JOIN brewery_address_info bai on brewery.brewery_id = bai.brewery_id " +
                "JOIN address_info ai on ai.address_id = bai.address_id " +
                "WHERE name = ? ";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, name);
        if(results.next()) {
            brewery = mapRowToBrewery(results);
        }
        return brewery;
    }

    @Override
    public boolean addBrewery(Brewery brewery, Principal principal) {
        String sql = "INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, hours, brewer_id) " +
                "VALUES (?,?,?,?,?,?,?) ";
        return  jdbcTemplate.update(sql,brewery.getBreweryName(), brewery.getDescription(), brewery.isHasOutDoorSeating(),
                brewery.isPetFriendly(), brewery.isHasFood(), brewery.isHasOnSiteBrewing(), brewery.getHours(), userDao.currentUser(principal).getId()) == 0;
    }

    @Override
    public boolean deleteBrewery(int breweryId) {
        String sql = "DELETE FROM brewery WHERE brewery_id = ? " ;

        return jdbcTemplate.update(sql,breweryId) == 0;
    }

    @Override
    public boolean updateBrewery(Brewery brewery) {
        String sql = "UPDATE brewery SET name = ?, description = ?, outdoor_seating = ?, pet_friendly = ?, serves_food = ?, on_site_brewing = ?, hours = ?" +
                ", brewer_id = ? WHERE brewery_id = ?" ;

        return jdbcTemplate.update(sql, brewery.getBreweryName(), brewery.getDescription(), brewery.isHasOutDoorSeating(),
                brewery.isPetFriendly(), brewery.isHasFood(), brewery.isHasOnSiteBrewing(), brewery.getHours(), brewery.getBrewerId() , brewery.getBreweryId()) == 0;
    }

    @Override
    public boolean registerBrewer(int breweryId, int brewerId) {
        String sql = "UPDATE brewery SET brewer_id = ? WHERE brewery_id = ?";
        return jdbcTemplate.update(sql, brewerId, breweryId) == 0;
    }


    public Brewery mapRowToBrewery(SqlRowSet sqlRowSet) {
        Brewery brewery = new Brewery();

        brewery.setBreweryId(sqlRowSet.getInt("brewery_id"));
        brewery.setBreweryName(sqlRowSet.getString("name"));
        brewery.setDescription(sqlRowSet.getString("description"));
        brewery.setHasOnSiteBrewing(sqlRowSet.getBoolean("on_site_brewing"));
        brewery.setHasOutDoorSeating(sqlRowSet.getBoolean("outdoor_seating"));
        brewery.setPetFriendly(sqlRowSet.getBoolean("pet_friendly"));
        brewery.setHasFood(sqlRowSet.getBoolean("serves_food"));
        brewery.setBrewerId(sqlRowSet.getInt("brewer_id"));
        brewery.setAddressId(sqlRowSet.getInt("address_id"));
        brewery.setPhoneNumber(sqlRowSet.getString("phone_number"));
        brewery.setLatitude(sqlRowSet.getDouble("latitude"));
        brewery.setLongitude(sqlRowSet.getDouble("longitude"));
        brewery.setHours(sqlRowSet.getString("hours"));
        return brewery;
    }

}
