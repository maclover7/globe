require 'rails_helper'

RSpec.describe CourseNotification, type: :model do
  it { should belong_to(:course) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:subject) }

  it 'has a valid factory' do
    expect(FactoryGirl.build(:course_notification)).to be_valid
  end
end

