require "rails_helper"

RSpec.describe CourseNotificationMailer, type: :mailer do
  describe 'In general' do
    before do
    @student = FactoryGirl.create(:student)
    @teacher = FactoryGirl.create(:teacher)
    @course = FactoryGirl.create(:course, teacher_id: @teacher.id)
    @enrollment = FactoryGirl.create(:enrollment)
    @course_notification = FactoryGirl.create(:course_notification, subject: 'Hi')
    @mail = CourseNotificationMailer.notify_student(@student, @course, @course_notification)
    end

    it 'sets the subject' do
      expect(@mail.subject).to eq('Hi')
    end

    it 'sets the receiver email' do
      expect(@mail.to).to eq([@student.email])
    end

    it 'sets the sender email' do
      expect(@mail.from).to eq([@teacher.email])
    end

    it 'assigns teacher name' do
      expect(@mail.body.encoded).to include("<h1>New Email from #{@teacher.name}</h1>")
    end

    it 'assigns course_notification body' do
      expect(@mail.body.encoded).to include(@course_notification.body)
    end
  end
end
