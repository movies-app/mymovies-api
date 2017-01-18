package com.mymovies.web;


import com.mymovies.movies.Movie;
import com.mymovies.movies.MoviesRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Arrays;
import java.util.List;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import static org.springframework.boot.test.context.SpringBootTest.WebEnvironment.MOCK;

import static org.mockito.BDDMockito.*;
import static org.hamcrest.Matchers.*;


@ExtendWith(SpringExtension.class)
@WebMvcTest(MoviesController.class)
public class MoviesControllerTest {

    @Autowired
    MockMvc mockMvc;

    @MockBean
    MoviesRepository moviesRepository;

    @Test
    @DisplayName("Welcome message")
    void welcomeMessage() throws Exception{

        this.mockMvc.perform(get("/hello").accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().json("{'app':'movies-api','message':'Welcome'}"));

    }


    @Test
    @DisplayName("List of available movies")
    void listOfMovies() throws Exception{
        List<Movie> movies = Arrays.asList(
                new Movie("Matrix", "sci-fi"),
                new Movie("Transformers", "robots"),
                new Movie("The notebook", "drama")
        );
        given(moviesRepository.findAll()).willReturn(movies);

        this.mockMvc.perform(get("/movies").accept(MediaType.APPLICATION_JSON))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$", hasSize(3)))
                    .andExpect(jsonPath("$[0].title", is("Matrix")))
                    .andExpect(jsonPath("$[1].title", is("Transformers")))
                    .andExpect(jsonPath("$[2].title", is("The notebook")))
        ;


    }
}
