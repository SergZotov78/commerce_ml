class Cost < ActiveRecord::Base
  belongs_to :product
  belongs_to :pricetype

  validates :title, :pricetype_id, :product_id, :price, presence: true
end
