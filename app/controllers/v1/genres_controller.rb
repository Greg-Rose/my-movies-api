module V1
  class GenresController < ApplicationController
    def index
      genres = Genre.all
      json_response(genres)
    end
  end
end
