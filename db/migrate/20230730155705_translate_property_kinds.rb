class TranslatePropertyKinds < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        PropertyKind.create_translation_table!({
          kind: :string
        }, {
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down do
        PropertyKind.drop_translation_table! :migrate_data => true
      end
    end
  end
end
