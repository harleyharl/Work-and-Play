Rails.application.routes.draw do

  root to: 'businesses#index'

  resources :sessions

  resources :businesses

  resources :business do
    resources :locations, :only => [:create, :index, :new, :show]
  end

  resources :locations

  resources :playlists
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
