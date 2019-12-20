class RemoveOptionFromAnswers < ActiveRecord::Migration[5.1]
  def change
    remove_column :answers, :option_id, :references
  end
end
