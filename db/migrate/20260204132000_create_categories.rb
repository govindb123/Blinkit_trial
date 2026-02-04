class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :icon
      t.timestamps
    end
    
    add_reference :items, :category, null: true, foreign_key: true
  end
end