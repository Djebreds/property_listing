class CreateVisitors < ActiveRecord::Migration[7.0]
  def change
    create_table :visitors do |t|
      t.inet :ip_address

      t.references :property, null: false, foreign_key: true
      t.timestamps
    end
  end
end
