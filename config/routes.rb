Rails.application.routes.draw do
  devise_for :users
  root :to => "catalog#index"
  blacklight_for :catalog
end
