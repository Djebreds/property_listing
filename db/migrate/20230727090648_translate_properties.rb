class TranslateProperties < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        Property.create_translation_table!({
          name: :string,
          location: :string,
          note: :string,
          description: :text
        }, {
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down do
        Property.drop_translation_table! :migrate_data => true
      end
    end
  end
end
