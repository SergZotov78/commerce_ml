class ChangeColumnProducts < ActiveRecord::Migration
  def up
    remove_index :products, :category_id
    remove_column :products, :category_id
    add_column :products, :category_id, :integer, default: 0
    add_index :products, :category_id
  end
end
