class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_id, index: true
      t.string :category_id, index: true
      t.string :title
      t.string :part_number
      t.text :full_text

      t.timestamps null: false
    end
  end
end
