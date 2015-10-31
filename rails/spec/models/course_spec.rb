require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should have_many(:assignments).dependent(:destroy) }
  it { should have_many(:enrollments).dependent(:destroy) }
  it { should have_many(:students).through(:enrollments) }
  it { should belong_to(:teacher) }
  it { should validate_presence_of(:name) }

  it 'has a valid factory' do
    expect(FactoryGirl.build(:course)).to be_valid
  end
end
