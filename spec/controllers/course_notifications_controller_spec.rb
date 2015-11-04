require 'rails_helper'

RSpec.describe CourseNotificationsController, type: :controller do

  describe "GET #create" do
    it "returns http 200" do
      @course = FactoryGirl.create(:course)
      get :create, course_id: @course.id, course_notification: FactoryGirl.attributes_for(:course_notification)
      expect(response.status).to eq(200)
    end
  end
end
