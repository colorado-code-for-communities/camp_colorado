CampColorado::Application.routes.draw do
  resource :search, only: [:show]

  devise_for :users

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root to: 'searches#new'
end
