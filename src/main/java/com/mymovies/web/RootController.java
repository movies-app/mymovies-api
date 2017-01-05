package com.mymovies.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RootController {

    private static final Logger LOG = LoggerFactory.getLogger(RootController.class);

    @GetMapping(path = "/", produces = MediaType.APPLICATION_JSON_VALUE)
    public String movieList() {
        LOG.debug("Welcome to my-movies-app");
        return "{\"welcome\":\"Welcome to my-movies-app\"}";
    }

}
