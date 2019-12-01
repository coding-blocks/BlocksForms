class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :text
      t.references :section, foreign_key: true
      t.integer :head_number
      t.text :description
      t.integer :question_type_id
      t.boolean :mandatory

      t.timestamps
    end
  end
end
