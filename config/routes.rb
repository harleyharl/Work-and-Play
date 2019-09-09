Rails.application.routes.draw do

  root to: 'businesses#index'

  get '/show_json', to: 'businesses#show_json'

  get '/login', to: 'sessions#new'

  get 'logout' => 'sessions#destroy'

  get '/moresongs' => 'songs#more_songs_by_artist'

  get 'badurl' => 'sessions#badurl'

  resources :sessions

  get '/auth/spotify/callback' => 'businesses#spotify_user'

  resources :locations do
    resources :playlists, :only => [:show]
  end

  resources :businesses do
    resources :locations, :only => [:create, :index, :new, :show, :destroy, :edit, :update]
    resources :playlists, :only => [:show, :index]
  end

  resources :playlists do
    resources :songs, :only => [:destroy]
  end

  get "/playlists/:playlist_id/songs/:song_id" => "songs#destroy"

  get '*path', to: redirect('/badurl')

end
