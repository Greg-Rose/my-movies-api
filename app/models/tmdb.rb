# Movies API from The Movie DB
# API documenation at https://www.themoviedb.org/documentation/api

module TMDB
  class Base
    @@base_url = "https://api.themoviedb.org/3"
    @@api_key = "api_key=#{ENV["TMDB_API_KEY"]}"

    def self.discover(options = { sort_by: "popularity.desc" })
      url = "#{@@base_url}/discover/#{@path}?#{@@api_key}&region=US&with_release_type=3"
      url += "&sort_by=#{options[:sort_by]}"
      url += "&with_genres=#{options[:genres]}" if options[:genres]
      url += "&page=#{options[:page]}" if options[:page]
      url += "&release_date.lte=#{options[:release_date_lte]}" if options[:release_date_lte]
      url += "&release_date.gte=#{options[:release_date_gte]}" if options[:release_date_gte]

      HTTParty.get(url).parsed_response
    end

    def self.search(query, page = nil)
      url = "#{@@base_url}/search/#{@path}?#{@@api_key}&query=#{query}"
      url += "&page=#{page}" if page

      HTTParty.get(url).parsed_response
    end

    def self.find(movie_id)
      url = "#{@@base_url}/#{@path}/#{movie_id}?#{@@api_key}&append_to_response=release_dates,videos,credits"

      HTTParty.get(url).parsed_response
    end

    def self.popular(page = nil)
      url = "#{@@base_url}/#{@path}/popular?#{@@api_key}"
      url += "&page=#{page}" if page

      HTTParty.get(url).parsed_response
    end

    def self.genres
      url = "#{@@base_url}/genre/#{@path}/list?#{@@api_key}&language=en-US"

      HTTParty.get(url).parsed_response
    end
  end

  class Movie < TMDB::Base
    @path = "movie"
  end
end
