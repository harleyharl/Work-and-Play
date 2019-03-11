Rails.application.routes.draw do

  root to: 'businesses#index'

  resource :business

  resource :location

  resource :playlist
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
