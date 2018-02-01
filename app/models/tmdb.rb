# Movies API from The Movie DB
# API documenation at https://www.themoviedb.org/documentation/api

module TMDB
  class Base
    @@base_url = "https://api.themoviedb.org/3"
    @@api_key = "api_key=#{ENV["TMDB_API_KEY"]}"

    def self.discover()
      url = "#{@@base_url}/discover/#{@path}?#{@@api_key}"

      HTTParty.get(url).parsed_response
    end

    def self.search(query)
      url = "#{@@base_url}/search/#{@path}?#{@@api_key}&query=#{query}"

      HTTParty.get(url).parsed_response
    end

    def self.find(movie_id)
      url = "#{@@base_url}/#{@path}/#{movie_id}?#{@@api_key}"

      HTTParty.get(url).parsed_response
    end
  end

  class Movie < TMDB::Base
    @path = "movie"
  end
end
