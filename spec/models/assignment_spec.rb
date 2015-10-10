require 'rails_helper'

RSpec.describe Assignment, type: :model do
  it { should belong_to(:course) }
  it { should have_many(:student_assignments).dependent(:destroy) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:name) }

  it 'has a valid factory' do
    expect(FactoryGirl.build(:assignment)).to be_valid
  end
end
