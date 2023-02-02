class CreateHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels do |t|
      t.string :name
      t.integer :meters_from_beach
      t.boolean :starlink
      t.timestamps 
    end
  end
end
