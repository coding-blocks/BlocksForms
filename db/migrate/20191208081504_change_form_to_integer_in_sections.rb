class ChangeFormToIntegerInSections < ActiveRecord::Migration[5.1]
  def up
    change_column :sections, :form_id, :bigint
  end
end
