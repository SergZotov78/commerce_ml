class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :pricetype_id, :integer
    add_column :users, :company, :string
    add_index :users, :pricetype_id
    add_column :users, :activated, :boolean, default: false
  end
end
