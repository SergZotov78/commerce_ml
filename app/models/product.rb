class Product < ActiveRecord::Base
  self.primary_key = "product_id"

  belongs_to :category
  has_many :costs

  validates :title, presence: true

end
