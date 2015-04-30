Rails.application.routes.draw do
  devise_for :users
  root :to => "catalog#index"
  blacklight_for :catalog

  get '/admin', :to => 'admin#index', :as => "admin_index"

  get '/about', :to => 'about#index', :as => 'about_index'
  get '/contact', :to => 'contact#index', :as => "contact"
  get '/help', :to => 'help#index', :as => "help"
  get '/geo/nearby', :to => 'geo#nearby', :as => "nearby_geo"

  namespace :admin do
    resources :coordinates
    resources :settings
  end
end
