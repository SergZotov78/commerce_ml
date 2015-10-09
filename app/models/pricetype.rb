class Pricetype < ActiveRecord::Base
  has_many :costs
  has_many :users

  validates :pricetype_id, :title, presence: true
end
