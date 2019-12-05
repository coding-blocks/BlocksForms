class CreateForms < ActiveRecord::Migration[5.1]
  def change
    create_table :forms do |t|
      t.string :name, null: false, default: ''
      t.text :description, null: false, default: ''
      t.boolean :finished, null: false, default: false
      t.boolean :active, null: false, default: true
      t.integer :attempts_number, null: false, default: 1

      t.timestamps
    end
  end
end
