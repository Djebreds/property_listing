class CreatePropertyOutdoors < ActiveRecord::Migration[7.0]
  def change
    create_table :property_outdoors do |t|
      t.integer :swimming_pool
      t.integer :garden
      t.integer :balcony

      t.references :property, null: false, foreign_key: true
      t.timestamps
    end
  end
end
