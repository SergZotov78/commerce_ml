class Product < ActiveRecord::Base

  belongs_to :category
  has_many :costs

  validates :title, presence: true

end
