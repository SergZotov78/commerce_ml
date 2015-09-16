class ChangeColumnCategory < ActiveRecord::Migration
  def change
    change_column :categories, :parent_id, :string
  end
end
