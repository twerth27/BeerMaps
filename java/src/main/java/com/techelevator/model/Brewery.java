package com.techelevator.model;

public class Brewery {
    private int breweryId;
    private String breweryName;
    private int brewerId;
    private int addressId;
    private boolean hasOnSiteBrewing;
    private boolean hasOutDoorSeating;
    private boolean isPetFriendly;
    private boolean hasFood;
    private String phoneNumber;
    private String description;
    private double latitude;
    private double longitude;
    private String hours;

    public Brewery(){
    }

    public Brewery(int breweryId, String breweryName, int brewerId, int addressId,
                   boolean hasOnSiteBrewing, boolean hasOutDoorSeating, boolean isPetFriendly, boolean hasFood,
                   String phoneNumber, String description, double latitude, double longitude) {
        this.breweryId = breweryId;
        this.breweryName = breweryName;
        this.brewerId = brewerId;
        this.addressId = addressId;
        this.hasOnSiteBrewing = hasOnSiteBrewing;
        this.hasOutDoorSeating = hasOutDoorSeating;
        this.isPetFriendly = isPetFriendly;
        this.hasFood = hasFood;
        this.phoneNumber = phoneNumber;
        this.description = description;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public String getHours() {return hours;}

    public void setHours(String hours) {this.hours = hours;}

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getBreweryId() {
        return breweryId;
    }

    public void setBreweryId(int breweryId) {
        this.breweryId = breweryId;
    }

    public String getBreweryName() {
        return breweryName;
    }

    public void setBreweryName(String breweryName) {
        this.breweryName = breweryName;
    }

    public int getBrewerId() {
        return brewerId;
    }

    public void setBrewerId(int brewerId) {
        this.brewerId = brewerId;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public boolean isHasOnSiteBrewing() {
        return hasOnSiteBrewing;
    }

    public void setHasOnSiteBrewing(boolean hasOnSiteBrewing) {
        this.hasOnSiteBrewing = hasOnSiteBrewing;
    }

    public boolean isHasOutDoorSeating() {
        return hasOutDoorSeating;
    }

    public void setHasOutDoorSeating(boolean hasOutDoorSeating) {
        this.hasOutDoorSeating = hasOutDoorSeating;
    }

    public boolean isPetFriendly() {
        return isPetFriendly;
    }

    public void setPetFriendly(boolean petFriendly) {
        isPetFriendly = petFriendly;
    }

    public boolean isHasFood() {
        return hasFood;
    }

    public void setHasFood(boolean hasFood) {
        this.hasFood = hasFood;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

}
