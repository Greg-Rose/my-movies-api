Rails.application.routes.draw do
  get '/movies/discover', to: 'movies#discover', as: 'discover_movies'
  get '/movies/search', to: 'movies#search', as: 'search_movies'
  get '/movies/find/:tmdb_id', to: 'movies#find', as: 'find_movie'
end
