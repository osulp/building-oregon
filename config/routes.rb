Rails.application.routes.draw do
  Blacklight::Marc.add_routes(self)
  devise_for :users
  root :to => "catalog#index"
  blacklight_for :catalog
end
