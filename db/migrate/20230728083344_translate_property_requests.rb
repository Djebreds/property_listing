class TranslatePropertyRequests < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        PropertyRequest.create_translation_table!({
          description: :text,
          property_category: :string,
          property_type: :string
        }, {
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down do
        PropertyRequest.drop_translation_table! :migrate_data => true
      end
    end
  end
end
