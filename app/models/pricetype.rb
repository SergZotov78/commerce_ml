class Pricetype < ActiveRecord::Base
  self.primary_key = "pricetype_id"
  has_many :costs

  validates :pricetype_id, :title, presence: true
end
