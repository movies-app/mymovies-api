package com.mymovies.movies;


import org.springframework.data.jpa.repository.JpaRepository;


public interface MoviesRepository extends JpaRepository<Movie, Long> {

}
