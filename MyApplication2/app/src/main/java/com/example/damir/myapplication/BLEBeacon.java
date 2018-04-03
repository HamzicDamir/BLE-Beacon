package com.example.damir.myapplication;

import java.util.ArrayList;

/**
 * Created by Damir on 11/6/2017.
 */

public class BLEBeacon {
    private String nameOfObject_;
    private String type_;
    private String address_;
    private String link_;
    private String information_;
    private double distance_;
    private String uuid_;
    private String major_;
    private String minor_;
    private String last_update_;
    private ArrayList<Information> informations_ = new ArrayList<Information>();

    public void setNameOfObject_(String nameOfObject){
    this.nameOfObject_ = nameOfObject;
}
    public void setType_(String type){
    this.type_ = type;
}
    public void setAddress_(String address){
    this.address_ = address;
}
    public void setLink_(String link){
    this.link_ = link;
}
    public void setInformation_(String information){
    this.information_ = information;
}
    public void setDistance_(double distance) {this.distance_ = distance;}
    public void setUuid_(String uuid) {this.uuid_ = uuid;}
    public void setMajor_(String major) {this.major_ = major;}
    public void setMinor_(String minor) {this.minor_ = minor;}
    public void setLast_update_(String lastUpdate) {this.last_update_ = lastUpdate;}
    public String getNameOfObject_(){
    return nameOfObject_;
}
    public String getType_(){
        return type_;
    }
    public String getAddress_(){
    return address_;
}
    public String getLink_(){
    return link_;
}
    public String getInformation_(){
    return information_;
}
    public double getDistance_() { return distance_;}
    public String getUuid_() { return uuid_;}
    public String getMajor_() { return major_;}
    public String getMinor_() { return minor_;}
    public String getLast_update_() { return last_update_;}
    public void addInformation(Information information){
        informations_.add(information);
    }
    public void setInformations(ArrayList<Information> informations){
        this.informations_ = informations;
    }
    public ArrayList<Information> getInformations(){return informations_;}
}