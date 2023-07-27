class CreatePropertyRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :property_requests do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone, null: false
      t.string :email, null: false
      t.text :description, null: false
      t.string :property_category, null: false
      t.string :property_type, null: false

      t.timestamps
    end
  end
end
