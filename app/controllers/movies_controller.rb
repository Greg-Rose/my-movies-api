class MoviesController < ApplicationController
  def discover
    movies = TMDB::Movie.discover
    json_response(movies)
  end

  def search
    movies = TMDB::Movie.search(params[:query])
    json_response(movies)
  end

  def find
    movie = TMDB::Movie.find(params[:tmdb_id])
    json_response(movie)
  end
end
