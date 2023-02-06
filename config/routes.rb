Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/', to: 'welcome#index'
  get '/hotels', to: 'hotels#index'
  get '/hotels/new', to: 'hotels#new' #takes us to the HTML page where we have the form, and once you fill out the form, it sends the POST request <form action="/hotels" method="post">. It sends to POST 
  get '/hotels/:id', to: 'hotels#show'
  get '/guests', to: 'guests#index'
  get '/guests/:id', to: 'guests#show'
  get '/hotels/:hotel_id/guests', to: 'hotel_guests#index'
  post '/hotels', to: 'hotels#create' 
  get '/hotels/:hotel_id/edit', to: 'hotels#edit'
  patch '/hotels/:id', to: 'hotels#update'
  get '/hotels/:hotel_id/guests/new', to: 'guests#new'
  post '/hotels/:hotel_id/guests', to: 'guests#create'
  get '/guests/:guest_id/edit', to: 'guests#edit'
  patch '/guests/:id', to: 'guests#update'
  get "/hotels/:hotel_id/guests/", to: 'hotel_guests#index'
  delete "/hotels/:id", to: "hotels#destroy"
  delete "/guests/:id", to: "guests#destroy"

end
