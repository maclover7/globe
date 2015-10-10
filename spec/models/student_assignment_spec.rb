require 'rails_helper'

RSpec.describe StudentAssignment, type: :model do
  it { should belong_to(:assignment) }
  it { should belong_to(:student) }

  it 'has a valid factory' do
    expect(FactoryGirl.build(:student_assignment)).to be_valid
  end
end
