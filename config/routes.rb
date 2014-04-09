Exchange::Application.routes.draw do

  resources :gambles

  root 'pages#home'

  devise_for :admins
  devise_for :users

  resources :transactions
  resources :orders
  resources :addresses

  get "pages/home"
  get "pages/status"
  get "pages/about"
  get "pages/contact"
  get "pages/finances"

end
