class AddCurrencyToPropertyRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :property_rentals, :currency, :string, default: 'IDR'
  end
end
