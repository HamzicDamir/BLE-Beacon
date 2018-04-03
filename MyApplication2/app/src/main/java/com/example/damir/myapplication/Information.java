package com.example.damir.myapplication;

/**
 * Created by Damir on 11/19/2017.
 */

public class Information {
    private String type_;
    private String text_;
    private String date_;
    private String link_;

    public void setType_(String type){type_ = type;}
    public void setText_(String text){text_ = text;}
    public void setDate_(String date){date_ = date;}
    public void setLink_(String link){link_ = link;}
    public String getType_(){return type_;}
    public String getText_(){return text_;}
    public String getDate_(){return date_;}
    public String getLink_(){return link_;}
}
