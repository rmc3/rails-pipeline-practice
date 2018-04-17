Rails.application.routes.draw do
  resources :users

  get 'welcome/index'
  get '/login', to: 'login#login'
  get '/logout', to: 'users#logout'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
end
