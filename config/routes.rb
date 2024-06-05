Rails.application.routes.draw do
  root 'weather_forecasts#index'
  resources :weather_forecasts, only: [:index]
end