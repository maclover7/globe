class CourseNotificationWorker
  include Sidekiq::Worker

  def perform(course_notification_id)
    @course_notification = CourseNotification.find(course_notification_id)
    @course = @course_notification.course
    @students = @course.students

    @students.each do |student|
      CourseNotificationMailer.notify_student(student, @course, @course_notification).deliver_now
    end
  end
end
