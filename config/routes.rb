Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :forecast, path: '/weather-forecast', only: [:fetch] do
    collection do
      get 'fetch'
    end
  end
end
