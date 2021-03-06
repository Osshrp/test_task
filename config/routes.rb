Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'calendars#index'

  resources :calendars
  resources :events do
    patch :share, on: :member
  end
end
