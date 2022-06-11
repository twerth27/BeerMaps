package com.techelevator.model;

public class Beverage {

    private int beverageId;
    private String beverageName;
    private double abv;
    private String description;
    private String beverageType;
    private int ibu;
    private String imageUrl;
    private boolean isAvailable;


    public Beverage(){
    }

    public Beverage(int beverageId, String beverageName, double abv, String description, String beverageType, int ibu, String imageUrl) {
        this.beverageId = beverageId;
        this.beverageName = beverageName;
        this.abv = abv;
        this.description = description;
        this.beverageType = beverageType;
        this.ibu = ibu;
        this.imageUrl = imageUrl;
    }
    public boolean isAvailable() {
        return isAvailable;
    }

    public void setIsAvailable(boolean isAvailable) {
        this.isAvailable = isAvailable;
    }

    public int getBeverageId() {
        return beverageId;
    }

    public void setBeverageId(int beverageId) {
        this.beverageId = beverageId;
    }

    public String getBeverageName() {
        return beverageName;
    }

    public void setBeverageName(String beverageName) {
        this.beverageName = beverageName;
    }

    public double getAbv() {
        return abv;
    }

    public void setAbv(double abv) {
        this.abv = abv;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getBeverageType() {
        return beverageType;
    }

    public void setBeverageType(String beverageType) {
        this.beverageType = beverageType;
    }

    public int getIbu() {
        return ibu;
    }

    public void setIbu(int ibu) {
        this.ibu = ibu;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }


}
