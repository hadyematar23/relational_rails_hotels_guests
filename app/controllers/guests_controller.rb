class GuestsController < ApplicationController
  def index 
    @guests = Guest.select_spanish_speakers
  end

  def show 
    @guest = Guest.find(params[:id])
  end

  def new
    @hotel = Hotel.find(params[:hotel_id])
  end

  def create 
    @hotel = Hotel.find(params[:hotel_id])

    guest = Guest.new({
      name: params[:Name], 
      spanish_speaker: nil,
      price_per_night_pesos: params[:MXP_per_night],
      hotel_id: @hotel.id
    })
    guest.boolean_print(params)
    
    guest.save

    redirect_to "/hotels/#{@hotel.id}/guests"
  end

  def edit 
    @guest = Guest.find(params[:guest_id])
  end

  def update 
    guest = Guest.find(params[:id])

    guest.update({
      name: params[:guest][:name], 
      spanish_speaker: nil,
      price_per_night_pesos: params[:guest][:price],
      hotel_id: guest.hotel_id
    })
    guest.boolean_print(params)
    guest.save

    redirect_to "/guests/#{guest.id}"
  end
end