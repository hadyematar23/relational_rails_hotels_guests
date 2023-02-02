class AddHotelToGuests < ActiveRecord::Migration[5.2]
  def change
    add_reference :guests, :hotel, foreign_key: true
  end
end
