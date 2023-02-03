class Hotel < ApplicationRecord
  has_many :guests
  
  def list_guests_by_hotel_id
    self.guests.where(hotel_id: self.id)
  end

  def self.order_hotels
    Hotel.all.order(created_at: :desc)
  end

  def count_guests
    self.guests.count
  end
  # It's a class because Hotel.order_hotels -- you are calling it on a class whereas for the list_guests_by_hotel_id, it's an instance method. 

end