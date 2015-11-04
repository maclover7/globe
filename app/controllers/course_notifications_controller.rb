class CourseNotificationsController < ApplicationController
  def create
    @course_notification = CourseNotification.new(course_notification_params)
    if @course_notification.save
      CourseNotificationWorker.perform_async(@course_notification.id)
      render json: {}, status: 200
    end
  end

  private

  def course_notification_params
    params.require(:course_notification).permit(:body, :course_id, :subject)
  end
end
