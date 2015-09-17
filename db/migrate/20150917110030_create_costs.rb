class CreateCosts < ActiveRecord::Migration
  def change
    create_table :costs do |t|
      t.string :cost_id, index: true
      t.string :product_id, index: true
      t.string :pricetype_id, index: true
      t.float :price, precision: 12, scale: 2
      t.string :title

      t.timestamps null: false
    end
  end
end
