CampColorado::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations", :passwords => "users/passwords"}

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
end
