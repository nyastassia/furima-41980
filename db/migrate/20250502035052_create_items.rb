class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :item_name, null: false
      t.text :description, null: false
      t.integer :price, null: false 
      t.references :user, null: false, foreign_key: true
      t.integer :category_id, null: false
      t.integer :condition_id, null: false
      t.integer :ship_cost_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :delivery_time_id, null: false

      t.timestamps
    end
  end
end
