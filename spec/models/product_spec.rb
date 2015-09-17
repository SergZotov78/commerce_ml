require 'rails_helper'

RSpec.describe Product, type: :model do
  it{ should belong_to :category }
  it{ should have_many :costs }
  it{ should validate_presence_of :title }
end
