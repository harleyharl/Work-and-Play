Rails.application.routes.draw do
  root to: 'businesses#index'

  resources :sessions

  post 'logout' => 'sessions#destroy'

  get '/auth/spotify/callback' => 'businesses#spotify_user'

  # get 'https://api.spotify.com/v1/users/#{@business_id}/playlists'

  resources :businesses

  resources :business do
    resources :locations, :only => [:create, :index, :new, :show]
  end

  resources :locations do
    resources :playlists
  end

  # resources :playlists
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
