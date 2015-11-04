require "rails_helper"
require 'sidekiq/testing'
Sidekiq::Testing.fake!

describe CourseNotificationWorker do
  describe "#perform" do
    before do
      @student = FactoryGirl.create(:student)
      @teacher = FactoryGirl.create(:teacher)
      @course = FactoryGirl.create(:course, teacher_id: @teacher.id)
      @enrollment = FactoryGirl.create(:enrollment)
    end

    context 'valid assignment' do
      before do
        @course_notification = FactoryGirl.create(:course_notification)
      end

      it "creates a CourseNotificationMailer" do
        expect {
          CourseNotificationWorker.perform_async(@course_notification.id) && CourseNotificationWorker.drain
        }.to change(ActionMailer::Base.deliveries, :count).by(1)
      end
    end
  end

  describe "queue" do
    before do
      @student = FactoryGirl.create(:student)
      @teacher = FactoryGirl.create(:teacher)
      @course = FactoryGirl.create(:course, teacher_id: @teacher.id)
      @enrollment = FactoryGirl.create(:enrollment)
      @course_notification = FactoryGirl.create(:course_notification)
    end

    it "is added to the queue" do
      expect {
        CourseNotificationWorker.perform_async(@course_notification.id)
      }.to change(CourseNotificationWorker.jobs, :size).by(1)
    end

    it "is removed from the queue when performed" do
      CourseNotificationWorker.jobs.clear
      expect(CourseNotificationWorker.jobs.size).to eq(0)
    end
  end
end
