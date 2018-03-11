module V1
  class MyMoviesController < ApplicationController
    # GET /my_watched_movies
    def watched
      @watched_movies = current_user.movies.watched.paginate(page: params[:page], per_page: 20)
      response = { movies: @watched_movies, page: @watched_movies.current_page, total_pages: @watched_movies.total_pages }
      json_response(response)
    end

    # GET /my_movies_to_watch
    def to_watch
      @movies_to_watch = current_user.movies.to_watch.paginate(page: params[:page], per_page: 20)
      response = { movies: @movies_to_watch, page: @movies_to_watch.current_page, total_pages: @movies_to_watch.total_pages }
      json_response(response)
    end

    # POST /my_movies
    def create
      # find or create movie in database
      movie = Movie.find_or_initialize_by(movie_params)

      if movie.new_record?
        movie.release_date = DateTime.parse(params[:release_date]) if params[:release_date]
        movie.save!
        params[:genres].each do |g|
          genre = Genre.find_or_create_by!(name: g["name"], tmdb_id: g["id"])
          movie.genres << genre
        end
      end

      # create my_movie belonging to current user
      watched = params["watched"] || false
      to_watch = params["to_watch"] || false
      @my_movie = current_user.my_movies.create!(movie: movie, watched: watched, to_watch: to_watch)
      json_response(@my_movie, :created)
    end

    # PUT /my_movies/:id
    def update
      @my_movie = MyMovie.find(params[:id])
      raise ExceptionHandler::AuthenticationError if @my_movie.user != current_user

      if params["watched"] && !@my_movie.watched
        @my_movie.update_attributes(watched: true, to_watch: false)
      else
        @my_movie.update_attributes(update_params)
      end

      json_response(@my_movie, :accepted)
    end

    # DELETE /my_movies/:id
    def destroy
      @my_movie = MyMovie.find(params[:id])
      raise ExceptionHandler::AuthenticationError if @my_movie.user != current_user

      @my_movie.destroy
      response = { to_watch: false, watched: false, id: nil }
      json_response(response, :accepted)
    end

    private

    def movie_params
      params.permit(:title, :tmdb_id, :runtime, :poster_path)
    end

    def update_params
      params.permit(:watched, :to_watch)
    end
  end
end
