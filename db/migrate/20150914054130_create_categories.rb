class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :category_id, index: true
      t.integer :parent_id, default: 0
      t.string :title

      t.timestamps null: false
    end
  end
end
