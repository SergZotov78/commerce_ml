class Category < ActiveRecord::Base
  has_many :products

  validates :category_id, :title, presence: true
end
