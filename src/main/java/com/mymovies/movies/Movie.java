package com.mymovies.movies;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Data
@Entity
public class Movie {

    @Id @GeneratedValue Long id;
    String title;
    String summary;


    private Movie(){ }

    public Movie(String title, String summary){
        this.title = title;
        this.summary = summary;
    }

}
