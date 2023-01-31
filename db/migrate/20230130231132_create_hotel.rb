class CreateHotel < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels do |t|
      t.string :name
      t.boolean :starlink
      t.integer :meters_from_beach
      t.timestamps
    end
  end
end
