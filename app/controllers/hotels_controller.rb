class HotelsController < ApplicationController
  def index 
    @hotels = Hotel.order_hotels
  end

  def show 
    @hotel = Hotel.find(params[:id])
    @count_of_guests = @hotel.count_guests
  end

  def new 
    
  end

  def create 
    hotel = Hotel.new({
      name: params[:Name], 
      meters_from_beach: params[:"Meters from Beach"],
      starlink: nil
    })
    hotel.boolean_print(params)
    hotel.save

    redirect_to '/hotels'
  end

  def edit 
    @hotel = Hotel.find(params[:hotel_id])
  end

  def update 

    hotel = Hotel.find(params[:id])
    hotel.update({
      name: params[:hotel][:name], 
      meters_from_beach: params[:hotel][:meters], 
      starlink: nil
    })
    hotel.boolean_print(params)
    hotel.save

    redirect_to "/hotels/#{hotel.id}"
  end
end