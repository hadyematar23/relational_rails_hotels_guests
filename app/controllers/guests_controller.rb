class GuestsController < ApplicationController
  
  def index 
    if params[:searchtext] != nil 
      @guests = Guest.search(params)
    else 
      @guests = Guest.select_spanish_speakers
    end
  end 

  def show 
    @guest = Guest.find(params[:id])
  end

  def new
    @hotel = Hotel.find(params[:hotel_id])
  end

  def create 
    @hotel = Hotel.find(params[:hotel_id])
    guest = Guest.new(guest_params)
    guest.save

    redirect_to "/hotels/#{@hotel.id}/guests"
  end

  def edit 
    @guest = Guest.find(params[:guest_id])
  end

  def update 
    guest = Guest.find(params[:id])
    guest.update(guest_params)

    redirect_to "/guests/#{guest.id}"
  end

  def destroy 
    @guest = Guest.find(params[:id])
    @guest.destroy

    redirect_to '/guests'
  end

  private
    def guest_params
      params.permit(:price_per_night_pesos, :name, :spanish_speaker, :hotel_id)
    end

end