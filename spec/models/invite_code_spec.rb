require 'rails_helper'

RSpec.describe InviteCode, type: :model do
  it { should validate_uniqueness_of(:code) }

  it 'has a valid factory' do
    expect(FactoryGirl.build(:invite_code)).to be_valid
  end
end
