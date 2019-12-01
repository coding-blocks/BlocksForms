class CreateSections < ActiveRecord::Migration[5.1]
  def change
    create_table :sections do |t|
      t.string :name
      t.text :description
      t.integer :head_number
      t.references :form, foreign_key: true

      t.timestamps
    end
  end
end
