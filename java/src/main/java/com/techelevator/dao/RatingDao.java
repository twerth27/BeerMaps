package com.techelevator.dao;

import com.techelevator.model.Rating;

import java.security.Principal;
import java.util.List;

public interface RatingDao {

    Rating getRatingByRatingId(int ratingId, String type);

    List<Rating> listRatingByType(String type);

    List<Rating> getRatingsByTypeAndId(int id, String type);

    boolean addRating(Rating rating, Principal principal);

    boolean deleteRating(int ratingId);

    boolean updateRating(Rating rating);

}
