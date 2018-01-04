Rails.application.routes.draw do
  get '/movies/discover', to: 'movies#discover', as: 'discover_movies'
  get '/movies/search', to: 'movies#search', as: 'search_movies'
  get '/movies/find/:tmdb_id', to: 'movies#find', as: 'find_movie'

  post '/sign_in', to: 'authentication#authenticate', as: 'sign_in'
  post '/sign_up', to: 'users#create', as: 'sign_up'

  get '/my_watched_movies', to: 'my_movies#watched', as: 'my_watched_movies'
  get '/my_movies_to_watch', to: 'my_movies#to_watch', as: 'my_movies_to_watch'
  post '/my_movies', to: 'my_movies#create'
  put '/my_movies/:id', to: 'my_movies#update'
end
