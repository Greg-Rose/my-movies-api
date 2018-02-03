module V1
  class MoviesController < ApplicationController
    def discover
      sort_by = params[:sort_by]
      page = params[:page]
      movies = TMDB::Movie.discover(sort_by, page)
      json_response(movies)
    end

    def search
      query = params[:query]
      page = params[:page]
      movies = TMDB::Movie.search(query, page)
      json_response(movies)
    end

    def find
      movie = TMDB::Movie.find(params[:tmdb_id])
      watched = current_user.movies.watched.where(tmdb_id: movie["id"])
      to_watch = current_user.movies.to_watch.where(tmdb_id: movie["id"])
      movie["watched"] = watched.present?
      movie["to_watch"] = to_watch.present?
      if watched.present? || to_watch.present?
        movie_record = Movie.find_by(tmdb_id: movie["id"])
        movie["my_movie_id"] = MyMovie.find_by(user: current_user, movie: movie_record).id
      end

      json_response(movie)
    end

    def popular
      page = params[:page]
      movies = TMDB::Movie.popular(page)
      json_response(movies)
    end
  end
end
