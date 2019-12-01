class CreateOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :options do |t|
      t.text :text
      t.references :question, foreign_key: true
      t.integer :option_type_id
      t.integer :head_number
      t.boolean :selected

      t.timestamps
    end
  end
end
