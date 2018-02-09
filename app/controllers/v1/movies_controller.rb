module V1
  class MoviesController < ApplicationController
    def discover
      options = {
        sort_by: params[:sort_by],
        genres: params[:genres],
        page: params[:page]
      }
      movies = TMDB::Movie.discover(options)
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

    def newest
      options = {
        sort_by: "primary_release_date.desc",
        release_date_lte: (Date.today + 1.weeks).to_s,
        release_date_gte: (Date.today - 1.years).to_s,
        page: params[:page]
      }
      movies = TMDB::Movie.discover(options)
      json_response(movies)
    end

    def upcoming
      options = {
        sort_by: "primary_release_date.asc",
        release_date_gte: (Date.today + 1.days).to_s,
        page: params[:page]
      }
      movies = TMDB::Movie.discover(options)
      json_response(movies)
    end
  end
end
