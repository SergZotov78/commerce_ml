require 'rails_helper'

RSpec.describe Pricetype, type: :model do
  it { should have_many :costs }
  it { should have_many :users }
end
