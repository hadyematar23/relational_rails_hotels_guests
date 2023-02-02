class CreateGuests < ActiveRecord::Migration[5.2]
  def change
    create_table :guests do |t|
      t.boolean :spanish_speaker
      t.integer :price_per_night_pesos
      t.string :name 
      t.timestamps
    end
  end
end
