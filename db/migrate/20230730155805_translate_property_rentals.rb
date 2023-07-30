class TranslatePropertyRentals < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        PropertyRental.create_translation_table!({
          rental_type: :string
        }, {
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down do
        PropertyRental.drop_translation_table! :migrate_data => true
      end
    end
  end
end
