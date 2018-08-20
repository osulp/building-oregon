Rails.application.routes.draw do
  mount Blacklight::Engine => '/'
  devise_for :users
  root :to => "catalog#index"

  get '/admin', :to => 'admin#index', :as => "admin_index"

  get '/about', :to => 'about#index', :as => 'about_index'
  get '/help', :to => 'help#index', :as => "help"
  get '/geo/frame', :to => 'geo#frame', :as => "frame_geo"
  get '/contact_us', :to => 'contacts#index', :as => "contact_us"
  post '/contact', :to => 'contacts#create', :as => "contact"
  namespace :admin do
    resources :coordinates
    resources :settings
  end
end
