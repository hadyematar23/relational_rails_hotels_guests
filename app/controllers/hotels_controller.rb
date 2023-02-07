class HotelsController < ApplicationController

  def index 
    if params[:sort] == "true"
      @hotels = Hotel.sort_by_number  
    elsif params[:searchtext] != nil 
      @hotels = Hotel.search(params)
    else
      @hotels = Hotel.order_hotels
    end
  end

  def show 
    @hotel = Hotel.find(params[:id])
    @count_of_guests = @hotel.count_guests
  end

  def new 

  end

  def create 
    hotel = Hotel.new(hotel_params)
    hotel.save

    redirect_to '/hotels'
  end

  def edit 
    @hotel = Hotel.find(params[:hotel_id])
  end

  def update 

    hotel = Hotel.find(params[:id])
    hotel.update(hotel_params)
      
    redirect_to "/hotels/#{hotel.id}"
  end

  def destroy 
    @hotel = Hotel.find(params[:id])
    @hotel.destroy

    redirect_to '/hotels'
  end

  private 
  def hotel_params
    params.permit(:name, :meters_from_beach, :starlink)
  end
end