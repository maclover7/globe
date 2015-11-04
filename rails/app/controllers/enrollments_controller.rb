class EnrollmentsController < ApplicationController
  before_action :authenticate_student!
  before_action :set_course

  def create
    if @enrollment = Enrollment.where(course_id: @course.id, student_id: current_student.id).exists?
      render json: {}, status: 422
    else
      @enrollment = Enrollment.create(course_id: @course.id, student_id: current_student.id)
      AssignmentLoaderWorker.perform_async(@course.id, current_student.id)
      render json: {}, status: 200
    end
  end

  private

  def set_course
    @course = Course.find_by(code: params['enrollment']['code'])
    render json: {}, status: 422 if @course.nil?
  end
end
