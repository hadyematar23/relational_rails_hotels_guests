class HotelGuestsController < ApplicationController
  
  def index 
    hotel = Hotel.find(params[:hotel_id])
    @hotel_guests = hotel.list_guests_by_hotel_id
  end
  
end 