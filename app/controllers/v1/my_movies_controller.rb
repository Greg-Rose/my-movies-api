module V1
  class MyMoviesController < ApplicationController
    # GET /my_watched_movies
    def watched
      @watched_movies = current_user.movies.watched.paginate(page: params[:page], per_page: 20)
      json_response(@watched_movies)
    end

    # GET /my_movies_to_watch
    def to_watch
      @movies_to_watch = current_user.movies.to_watch.paginate(page: params[:page], per_page: 20)
      json_response(@movies_to_watch)
    end

    # POST /my_movies
    def create
      # find or create movie in database
      movie = Movie.find_or_initialize_by(movie_params)

      if movie.new_record?
        movie.release_date = DateTime.parse(params[:release_date]) if params[:release_date]
        movie.save!
        params[:genres].each { |g| movie.genres.find_or_create_by!(name: g["name"]) }
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

      if !@my_movie.watched && !@my_movie.to_watch
        @my_movie.destroy
        head :no_content
      else
        json_response(@my_movie, :accepted)
      end
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
