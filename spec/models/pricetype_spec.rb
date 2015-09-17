require 'rails_helper'

RSpec.describe Pricetype, type: :model do
  it { should have_many :costs }
end
