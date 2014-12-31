Rails.application.routes.draw do
  devise_for :users
  root :to => "catalog#index"
  blacklight_for :catalog

  get '/admin', :to => 'admin#index', :as => "admin_index"

  namespace :admin do
    resources :coordinates
    resources :settings
  end
end
