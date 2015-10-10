require 'rails_helper'

RSpec.describe Teacher, type: :model do
  it { should have_many(:courses) }

  it 'has a valid factory' do
    expect(FactoryGirl.build(:teacher)).to be_valid
  end
  it_should_behave_like "a user"
end
