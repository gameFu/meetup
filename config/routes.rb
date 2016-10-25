Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  resources :users

  get 'signup' => 'users#new'
  get 'login' => 'session#new'
  post 'login' => 'session#create'

end
