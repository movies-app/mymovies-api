package com.mymovies.web;


import com.mymovies.movies.Movie;
import com.mymovies.movies.MoviesRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;


@RestController
public class MoviesController {

    private static final Logger LOG = LoggerFactory.getLogger(MoviesController.class);

    private MoviesRepository moviesRepository;

    public MoviesController(MoviesRepository moviesRepository){
        this.moviesRepository = moviesRepository;
    }

    @GetMapping(path = "/hello", produces = MediaType.APPLICATION_JSON_VALUE)
    public String hello(){
        return "{\"app\":\"movies-api\",\"message\":\"Welcome\"}";
    }

    @GetMapping(path = "/movies", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Movie> movieList() {
        LOG.debug("Inside movie list controller");
        List<Movie> movies = this.moviesRepository.findAll();
        return movies;
    }

    @PostMapping(path = "/movie", produces = MediaType.APPLICATION_JSON_VALUE)
    public Movie newMovie(){
        LOG.debug("Inside new movie controller");
        Movie movie = new Movie("Some Title", "Some Description");
        Movie newMovie = this.moviesRepository.save(movie);
        return newMovie;
    }


}
