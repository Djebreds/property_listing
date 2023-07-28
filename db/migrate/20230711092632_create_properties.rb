class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :name, null: false, default: ""
      t.text :description, null: false, default: ""
      t.boolean :is_available, null: false, default: false
      t.string :note
      t.decimal :latitude, default: 0, null: false, precision: 10, scale: 6
      t.decimal :longitude, default: 0, null: false, precision: 10, scale: 6
      t.string :location, null: false, default: ""
      t.integer :created_by, null: false, default: 0
      t.string :created_with, null: false, default: ""

      t.timestamps
    end
  end
end
