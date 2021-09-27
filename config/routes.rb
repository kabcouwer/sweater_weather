Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      # resources :forecast, only: [:index]
      get 'forecast', to: 'forecast#index'
      get 'backgrounds', to: 'backgrounds#index'
    end
  end
end
