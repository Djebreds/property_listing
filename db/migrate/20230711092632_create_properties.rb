class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.boolean :is_available, null: false, default: true
      t.date :available_on
      t.string :note
      t.integer :created_by, null: false, default: 0

      t.timestamps
    end
  end
end
