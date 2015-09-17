require 'rails_helper'

RSpec.describe Cost, type: :model do
  it { should belong_to :product }
  it { should belong_to :pricetype }
end
