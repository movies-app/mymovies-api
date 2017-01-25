package com.mymovies.movies;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
public class Movie {

    @Id @GeneratedValue(generator = "movieSeq")
    @SequenceGenerator(name="movieSeq",sequenceName="MOVIE_SEQ", allocationSize=1)
    Long id;
    String title;
    String summary;


    private Movie(){ }

    public Movie(String title, String summary){
        this.title = title;
        this.summary = summary;
    }

}
