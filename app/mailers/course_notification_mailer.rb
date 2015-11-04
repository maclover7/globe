class CourseNotificationMailer < ApplicationMailer
  def notify_student(student, course, course_notification)
    @student = student
    @course = course
    @course_notification = course_notification
    mail(
      to: @student.email,
      from: @course.teacher.email,
      subject: @course_notification.subject
    )
  end
end
