class Hotel < ApplicationRecord
  has_many :guests, dependent: :destroy
  
  def list_guests_by_hotel_id
    self.guests.where(hotel_id: self.id)
  end

  def self.order_hotels
    Hotel.all.order(created_at: :desc)
  end
    # It's a class because Hotel.order_hotels -- you are calling it on a class whereas for the list_guests_by_hotel_id, it's an instance method. 

  def count_guests
    self.guests.count
  end



  def alphabetize
    self.guests.where(hotel_id: self.id).order(:name)
  end

  def meet_threshold(pesos)
    self.guests.where("price_per_night_pesos > #{pesos}")
  end

  def self.sort_by_number
    left_joins(:guests).group(:id).order("COUNT(guests.id) DESC")
  end

  def self.search(params)
    @hotels = []
    if find_by(name: params[:searchtext]) != nil
      @hotels << find_by(name: params[:searchtext])
    else 
      @hotels << where("name LIKE ?", "%#{params[:searchtext]}%")
    end 
    return @hotels.flatten
  end



end