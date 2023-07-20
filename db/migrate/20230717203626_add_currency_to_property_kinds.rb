class AddCurrencyToPropertyKinds < ActiveRecord::Migration[7.0]
  def change
    add_column :property_kinds, :currency, :string, default: 'IDR'
  end
end
