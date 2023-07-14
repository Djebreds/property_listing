class CreatePropertyLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :property_locations do |t|
      t.decimal :latitude, default: 0, null: false, precision: 10, scale: 6
      t.decimal :longitude, default: 0, null: false, precision: 10, scale: 6
      t.string :name

      t.timestamps
    end
  end
end
