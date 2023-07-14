class CreatePropertyGenerals < ActiveRecord::Migration[7.0]
  def change
    create_table :property_generals do |t|
      t.string :land_size, null: false, default: 0
      t.string :building_size, null: false, default: 0
      t.integer :floor_level
      t.string :view
      t.integer :style_design
      t.string :surrounding

      t.references :property, null: false, foreign_key: true
      t.timestamps
    end
  end
end
