class Product < ActiveRecord::Base
  self.primary_key = "product_id"

  belongs_to :category

  validates :title, presence: true

end
