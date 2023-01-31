class HotelsController < ApplicationController
  def index 
    @hotels = Hotel.all
  end

  def show 
    @hotel = Hotel.find(params[:id])
  end
end