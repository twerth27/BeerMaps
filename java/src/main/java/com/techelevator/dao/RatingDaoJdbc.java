package com.techelevator.dao;

import com.techelevator.model.Rating;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Component
public class RatingDaoJdbc implements RatingDao{

    private JdbcTemplate jdbcTemplate;
    private JdbcUserDao userDao;

    public RatingDaoJdbc (JdbcTemplate jdbcTemplate, JdbcUserDao userDao){
        this.jdbcTemplate = jdbcTemplate;
        this.userDao = userDao;
    }

    @Override
    public Rating getRatingByRatingId(int ratingId, String type) {
       Rating rating = null;
       String sql = "";
        if(type.equals("beverage")){
            sql = "SELECT rating_id, rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id " +
                    "FROM rating WHERE rating_id = ?";
        } else if (type.equals("brewery")){
            sql = "SELECT rating_id, rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id " +
                    "FROM rating WHERE rating_id = ?";
        }
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, ratingId);
        if(results.next()){
            rating = mapRowToRatingWithType(results, type);
        }
        return rating;
    }

    @Override
    public List<Rating> listRatingByType(String type) {
        List<Rating> ratingList = new ArrayList<>();
        String sql = "";
        if(type.equals("beverage")){
            sql = "SELECT rating_id, rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id " +
                    "FROM rating WHERE rating_type = ?";
        } else if (type.equals("brewery")){
            sql = "SELECT rating_id, rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id " +
                    "FROM rating WHERE rating_type = ?";
        }
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, type);
        while(results.next()){
            Rating rating = mapRowToRatingWithType(results, type);
            ratingList.add(rating);
        }
        return ratingList;
    }

    @Override
    public List<Rating> getRatingsByTypeAndId(int id, String type) {
        List<Rating> ratingList = new ArrayList<>();
        String sql = "";
        if(type.equals("beverage")){
           sql = "SELECT rating_id, rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id " +
                 "FROM rating WHERE beverage_id = ?";
        } else if (type.equals("brewery")){
            sql = "SELECT rating_id, rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id " +
                    "FROM rating WHERE brewery_id = ?";
        }
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, id);
        while(results.next()){
            Rating rating = mapRowToRatingWithType(results, type);
            ratingList.add(rating);
        }
        return ratingList;
    }

    @Override
    public boolean addRating(Rating rating, Principal principal) {
        String sql = "";
        if(rating.getType().equals("beverage")){
            sql = "INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id) " +
            "VALUES (?,?,?,?,?,?) ";
        } else if(rating.getType().equals("brewery")){
            sql = "INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id) " +
                    "VALUES (?,?,?,?,?,?) ";
        }
        return jdbcTemplate.update(sql, rating.getRatingText(), rating.getRating(), rating.getDate(),
                rating.getType(), rating.getId(), userDao.currentUser(principal).getId()) == 0;
    }

    @Override
    public boolean deleteRating(int ratingId) {
        String sql = "DELETE FROM rating WHERE rating_id = ?";
        return jdbcTemplate.update(sql, ratingId) == 0;
    }

    @Override
    public boolean updateRating(Rating rating) {
        String sql = "";
        if(rating.getType().equals("beverage")){
            sql = "UPDATE rating SET rating_text = ?, rating = ?, rating_date = ?, rating_type = ?, " +
                    "beverage_id = ?, reviewer_id = ? WHERE rating_id = ? ";
        } else if(rating.getType().equals("brewery")){
            sql = "UPDATE rating SET rating_text = ?, rating = ?, rating_date = ?, rating_type = ?, " +
                    "brewery_id = ?, reviewer_id = ? WHERE rating_id = ? ";
        }
        return jdbcTemplate.update(sql, rating.getRatingText(), rating.getRating(), rating.getDate(),
                rating.getType(), rating.getId(), rating.getReviewerId(), rating.getRatingId()) == 0;
    }

    public Rating mapRowToRatingWithType(SqlRowSet rowSet, String type){
        Rating rating = new Rating();
        if(type.equals("beverage")){
            rating.setId(rowSet.getInt("beverage_id"));
        } else if (type.equals("brewery")){
            rating.setId(rowSet.getInt("brewery_id"));
        }
        rating.setRatingId(rowSet.getInt("rating_id"));
        rating.setRatingText(rowSet.getString("rating_text"));
        rating.setDate(rowSet.getDate("rating_date").toLocalDate());
        rating.setType(rowSet.getString("rating_type"));
        rating.setReviewerId(rowSet.getInt("reviewer_id"));
        rating.setRating(rowSet.getInt("rating"));
        return rating;
    }
}
