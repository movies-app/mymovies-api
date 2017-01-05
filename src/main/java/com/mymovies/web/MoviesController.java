package com.mymovies.web;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MoviesController {

    private static final Logger LOG = LoggerFactory.getLogger(MoviesController.class);

    @GetMapping(path = "/movies", produces = MediaType.APPLICATION_JSON_VALUE)
    public String movieList() {
        LOG.debug("Inside movie list controller");
        return "{\"make\":\"Honda\",\"model\":\"Civic\"}";
    }


}
