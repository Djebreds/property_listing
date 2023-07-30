class TranslatePropertyKindCosts < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        PropertyKindCost.create_translation_table!({
          name: :string,
          value: :string
        }, {
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down do
        PropertyKindCost.drop_translation_table! :migrate_data => true
      end
    end
  end
end
