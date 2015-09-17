class CreatePricetypes < ActiveRecord::Migration
  def change
    create_table :pricetypes do |t|
      t.string :pricetype_id, index: true
      t.string :title

      t.timestamps null: false
    end
  end
end
