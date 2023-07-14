class CreatePropertyCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :property_categories do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
