Rails.application.routes.draw do
  resources :sessions
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'new', to: 'games#new'
  post 'score', to: 'games#score'
end
