class HotelGuestsController < ApplicationController
  
  def index 
    @hotel = Hotel.find(params[:hotel_id])

    if params[:alpha] == "true" 
      @hotel_guests = @hotel.alphabetize
    else #no alphabetize
      @hotel_guests = @hotel.list_guests_by_hotel_id
    end 
  end
end 