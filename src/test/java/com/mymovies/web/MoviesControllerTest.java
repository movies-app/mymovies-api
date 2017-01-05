package com.mymovies.web;


import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import static org.springframework.boot.test.context.SpringBootTest.WebEnvironment.MOCK;


@ExtendWith(SpringExtension.class)
@WebMvcTest(MoviesController.class)
//@SpringBootTest
//@AutoConfigureMockMvc
public class MoviesControllerTest {

    @Autowired
    MockMvc mockMvc;

    @Test
    @DisplayName("The list of movies")
    void listOfMovies() throws Exception{

        this.mockMvc.perform(get("/movies").accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().json("{'make':'Honda','model':'Civic'}"));

    }

}
