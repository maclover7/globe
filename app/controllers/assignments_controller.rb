class AssignmentsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_course
  before_action :correct_teacher

  def create
    due_date = Time.parse(params['assignment']['due_date'] + "12:00:00 AM")
    @assignment = Assignment.create(category: params['assignment']['category'],
                                    course_id: @course.id,
                                    description: params['assignment']['description'],
                                    due_date: due_date,
                                    name: params['assignment']['name'])
    render json: {}, status: 200
  end

  def destroy
    @assignment = Assignment.find_by(id: params[:assignment_id])
    @assignment.destroy
    redirect_to course_path(@course)
  end

  private

  def correct_teacher
    @course = current_teacher.courses.find_by(id: params[:course_id])
    render json: {}, status: 422 if @course.nil?
  end

  def set_course
    @course = Course.find_by(id: params[:course_id])
    render json: {}, status: 422 if @course.nil?
  end
end
