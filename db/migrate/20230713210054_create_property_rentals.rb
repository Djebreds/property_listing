class CreatePropertyRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :property_rentals do |t|
      t.integer :rental_type, default: 0, null: false
      t.monetize :price, precision: 12, scale: 2

      t.references :property, null: false, foreign_key: true
      t.index [:rental_type, :property_id], unique: true
      t.timestamps
    end
  end
end
