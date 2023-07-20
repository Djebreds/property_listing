class CreatePropertyKinds < ActiveRecord::Migration[7.0]
  def change
    create_table :property_kinds do |t|
      t.integer :kind, default: 0, null: false
      t.monetize :price, precision: 12, scale: 2

      t.references :property, null: false, foreign_key: true
      t.index [:kind, :property_id], unique: true
      t.timestamps
    end
  end
end
