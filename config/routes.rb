Rails.application.routes.draw do
  get 'sessions/new'

  get 'signup' => 'users#new'

  root             'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  resources :users

  get 'login' => 'session#new'
  post 'login' => 'session#create'
  delete 'logout' => 'sessions#destroy'
  
end