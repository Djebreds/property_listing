class AddPropertyCategoriesToProperty < ActiveRecord::Migration[7.0]
  def change
    add_reference :properties, :property_category, null: false, foreign_key: true
  end
end
