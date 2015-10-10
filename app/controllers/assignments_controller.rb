class AssignmentsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_course

  def create
    @assignment = Assignment.create(course_id: @course.id,
                                    description: params['assignment']['description'],
                                    name: params['assignment']['name'])
    render json: {}, status: 200
  end

  private

  def set_course
    @course = Course.find_by(id: params[:course_id])
    render json: {}, status: 422 if @course.nil?
  end
end

