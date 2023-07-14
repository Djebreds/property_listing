class CreatePropertyKindCosts < ActiveRecord::Migration[7.0]
  def change
    create_table :property_kind_costs do |t|
      t.references :property_rental, null: false, foreign_key: true
      t.string :name, null: false
      t.string :value, null: false
      t.timestamps
    end
  end
end
