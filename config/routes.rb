Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/hotels', to: 'hotels#index'
  get '/hotels/:id', to: 'hotels#show'
end
