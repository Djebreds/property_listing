class TranslatePropertyGenerals < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        PropertyGeneral.create_translation_table!({
          view: :string,
          surrounding: :string
        }, {
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down do
        PropertyGeneral.drop_translation_table! :migrate_data => true
      end
    end
  end
end
