Rails.application.routes.draw do
  root to: 'businesses#index'

  resources :sessions

  post 'logout' => 'sessions#destroy'

  get '/auth/spotify/callback' => 'businesses#spotify_user'

  # get 'https://api.spotify.com/v1/users/#{@business_id}/playlists'

  resources :businesses

  resources :business do
    resources :locations, :only => [:create, :index, :new, :show]
    resources :playlists, :only => [:show]
  end

  resources :locations do
    resources :playlists, :only => [:create, :index, :new]
  end

  resources :playlists do
    resources :songs, :only => [:destroy]
  end

  get "/playlists/:playlist_id/songs/:song_id" => "songs#destroy"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
