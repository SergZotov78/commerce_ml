class Product < ActiveRecord::Base

  belongs_to :category
  has_many :costs

  validates :title, presence: true

  scope :willamount, ->{ where "amount > 0"}

  scope :by_categories_id, ->(cat_ids){ where({category_id: cat_ids}) }

end
