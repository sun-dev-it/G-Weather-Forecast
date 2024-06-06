Rails.application.routes.draw do
  root 'weather_forecasts#index'
  resources :weather_forecasts, only: [:index]
  delete 'users', to: 'users#destroy', as: 'destroy_user'
  post 'users', to: 'users#create', as: 'create_user'
end