class CreateForms < ActiveRecord::Migration[5.1]
  def change
    create_table :forms do |t|
      t.string :name
      t.text :description
      t.boolean :finished
      t.boolean :active
      t.integer :attempts_number

      t.timestamps
    end
  end
end
