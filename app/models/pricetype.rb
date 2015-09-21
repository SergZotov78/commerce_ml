class Pricetype < ActiveRecord::Base
  has_many :costs

  validates :pricetype_id, :title, presence: true
end
