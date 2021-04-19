Rails.application.routes.draw do


  resources :users, only: [:create] do #只保留create路徑
    collection do
      get :sign_up, action: 'new'
    end
  end

  resources :sessions, path: 'users', only: [] do #只保留destroy路徑
    collection do
      get :sign_in, action: 'new'
      post :sign_in, action: 'create'
      delete :sign_out, action: 'destroy'
    end
  end

  resources :restaurants
  root "restaurants#index"


  # get '/restaurants', to: 'restaurants#index'

  # get '/new_restaurant', to: 'restaurants#new'

  # post '/restaurant_list', to: 'restaurants#list'
end
