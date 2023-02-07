class HotelGuestsController < ApplicationController
  
  def index 
    @hotel = Hotel.find(params[:hotel_id])
    if params[:alpha] == "true" 
      @hotel_guests = @hotel.alphabetize
    elsif params[:pesos] != nil 
      @hotel_guests = @hotel.meet_threshold(params[:pesos])
    else 
      @hotel_guests = @hotel.list_guests_by_hotel_id
    end 
  end
end 