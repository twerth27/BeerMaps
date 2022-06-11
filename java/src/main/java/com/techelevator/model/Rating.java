package com.techelevator.model;

import java.time.LocalDate;

public class Rating {


    private int ratingId;
    private int id;
    private String type;
    private int reviewerId;
    private int rating;
    private String ratingText;
    private LocalDate date;

    public Rating(){

    }

    public Rating(int id, String type, int reviewerId, int rating, String ratingText, LocalDate date, int ratingId) {
        this.id = id;
        this.type = type;
        this.reviewerId = reviewerId;
        this.rating = rating;
        this.ratingText = ratingText;
        this.date = date;
        this.ratingId = ratingId;
    }

    public int getRatingId() {return ratingId;}

    public void setRatingId(int ratingId) {this.ratingId = ratingId;}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getReviewerId() {
        return reviewerId;
    }

    public void setReviewerId(int reviewerId) {
        this.reviewerId = reviewerId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getRatingText() {
        return ratingText;
    }

    public void setRatingText(String ratingText) {
        this.ratingText = ratingText;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }
}
