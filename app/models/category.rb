class Category < ActiveRecord::Base
  self.primary_key = "category_id"

  has_many :products

  validates :category_id, :title, presence: true
end
