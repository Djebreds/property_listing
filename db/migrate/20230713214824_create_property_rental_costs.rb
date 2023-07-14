class CreatePropertyRentalCosts < ActiveRecord::Migration[7.0]
  def change
    create_table :property_rental_costs do |t|
      t.references :property_rental, null: false, foreign_key: true
      t.string :name, null: false
      t.string :value, null: false
    end
  end
end
