require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:enrollment)).to be_valid
  end

  it { should belong_to(:course) }
  it { should belong_to(:student) }
end
