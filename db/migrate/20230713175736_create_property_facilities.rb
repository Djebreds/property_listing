class CreatePropertyFacilities < ActiveRecord::Migration[7.0]
  def change
    create_table :property_facilities do |t|
      t.integer :furniture
      t.integer :electric_power
      t.integer :air_conditioner
      t.integer :water_resource
      t.integer :internet
      t.integer :parking

      t.references :property, null: false, foreign_key: true
      t.timestamps
    end
  end
end
