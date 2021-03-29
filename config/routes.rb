Rails.application.routes.draw do
  get '/restaurants', to: 'restaurants#index'

  get '/books', to: 'books#index'

end
