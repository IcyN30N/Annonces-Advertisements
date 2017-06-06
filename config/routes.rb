Rails.application.routes.draw do
  root 'advertisements#landing'
  resources :comments
  resources :advertisements
  # login and logout routes
  get 'users/login' => 'users#login'
  post 'users/login' => 'users#login_check'
  get 'users/logout' => 'users#logout'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
