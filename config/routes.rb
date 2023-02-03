Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/hotels', to: 'hotels#index'
  get '/hotels/:id', to: 'hotels#show'
  get '/guests', to: 'guests#index'
  get '/guests/:id', to: 'guests#show'
  get '/hotels/:hotel_id/guests', to: 'hotel_guests#index'
  get '/individual_hotel/:hotel_id', to: 'hotel#index'

end
