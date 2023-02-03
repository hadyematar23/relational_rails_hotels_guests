class HotelController < ApplicationController
  def index 
    @hotel = Hotel.find(params[:hotel_id])
  end
end 