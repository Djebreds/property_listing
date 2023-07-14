class CreatePropertyRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :property_rentals do |t|
      t.integer :rental_type, index: { unique: true }, default: 0, null: false
      t.decimal :price, null: false, default: "0.0"

      t.references :property, null: false, foreign_key: true
      t.timestamps
    end
  end
end
