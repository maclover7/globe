class CourseNotificationsController < ApplicationController
  def create
    @course_notification = CourseNotification.new(course_notification_params)
    if @course_notification.save
      #AssignmentCreatorWorker.perform_async(@assignment.id)
      render json: {}, status: 200
    end
  end

  private

  def course_notification_params
    params.require(:course_notification).permit(:body, :course_id, :subject)
  end
end
