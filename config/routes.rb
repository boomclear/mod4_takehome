Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      post '/subscribe', to: 'subscription#new'
      delete '/subscribe', to: 'subscription#cancel'
      get '/subscribe', to: 'subscription#index'
    end
  end
end
