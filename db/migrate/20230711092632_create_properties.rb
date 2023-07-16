class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.boolean :is_available, null: false, default: true
      t.date :available_on
      t.string :note
      t.decimal :latitude, default: 0, null: false, precision: 10, scale: 6
      t.decimal :longitude, default: 0, null: false, precision: 10, scale: 6
      t.string :location, null: false
      t.integer :created_by, null: false, default: 0

      t.timestamps
    end
  end
end
