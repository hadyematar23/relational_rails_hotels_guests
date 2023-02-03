class HotelsController < ApplicationController
  def index 
    @hotels = Hotel.order_hotels
  end

  def show 
    @hotel = Hotel.find(params[:id])
  end

  def show_hotel_guests
    hotel = Hotel.find(params[:hotel_id])
    @hotel_guests = hotel.list_guests_by_hotel_id
  end
end