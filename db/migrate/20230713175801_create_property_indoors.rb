class CreatePropertyIndoors < ActiveRecord::Migration[7.0]
  def change
    create_table :property_indoors do |t|
      t.integer :living_room
      t.integer :dinning_room
      t.integer :kitchen
      t.integer :bedroom
      t.integer :ensuite_bathroom
      t.integer :maid_room
      t.integer :storage
      t.integer :guest_toilet

      t.references :property, null: false, foreign_key: true
      t.timestamps
    end
  end
end
