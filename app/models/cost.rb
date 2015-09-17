class Cost < ActiveRecord::Base
  self.primary_key = "cost_id"

  belongs_to :product
  belongs_to :pricetype

  validates :title, :cost_id, presence: true
end
