Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    get '/movies/discover', to: 'movies#discover', as: 'discover_movies'
    get '/movies/search', to: 'movies#search', as: 'search_movies'
    get '/movies/find/:tmdb_id', to: 'movies#find', as: 'find_movie'
    get '/movies/popular', to: 'movies#popular', as: 'popular_movies'
    get '/movies/newest', to: 'movies#newest', as: 'newest_movies'
    get '/movies/upcoming', to: 'movies#upcoming', as: 'upcoming_movies'

    get '/my_watched_movies', to: 'my_movies#watched', as: 'my_watched_movies'
    get '/my_movies_to_watch', to: 'my_movies#to_watch', as: 'my_movies_to_watch'
    post '/my_movies', to: 'my_movies#create'
    put '/my_movies/:id', to: 'my_movies#update'
    delete '/my_movies/:id', to: 'my_movies#destroy'

    resources :genres, only: [:index]
  end

  post '/sign_in', to: 'authentication#authenticate', as: 'sign_in'
  post '/sign_up', to: 'users#create', as: 'sign_up'
  get '/account', to: 'users#edit', as: 'my_account'
  put '/account', to: 'users#update', as: 'update_my_account'
end
