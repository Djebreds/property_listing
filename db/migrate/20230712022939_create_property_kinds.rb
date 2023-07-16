class CreatePropertyKinds < ActiveRecord::Migration[7.0]
  def change
    create_table :property_kinds do |t|
      t.integer :kind, index: { unique: true }, default: 0, null: false
      t.decimal :price, null: false, default: "0.0"

      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end