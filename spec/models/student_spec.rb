require 'rails_helper'

RSpec.describe Student, type: :model do
  it { should have_many(:courses).through(:enrollments) }
  it { should have_many(:enrollments).dependent(:destroy) }
  it { should have_many(:student_assignments).dependent(:destroy) }

  it 'has a valid factory' do
    expect(FactoryGirl.build(:student)).to be_valid
  end
  it_should_behave_like "a user"
end

