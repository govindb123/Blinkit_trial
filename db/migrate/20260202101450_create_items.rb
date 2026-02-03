class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
