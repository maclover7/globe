require 'rails_helper'

RSpec.describe Course, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:course)).to be_valid
  end

  it { should belong_to(:teacher) }
  it { should have_many(:enrollments).dependent(:destroy) }
  it { should have_many(:students).through(:enrollments) }
  it { should validate_presence_of(:name) }
end
