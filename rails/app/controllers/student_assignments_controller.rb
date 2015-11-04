class StudentAssignmentsController < ApplicationController
  before_action :authenticate_student!
  before_action :set_student_assignment

  def complete
    @student_assignment.completed = true
    @student_assignment.save!
    render json: {}, status: 200
  end

  private

  def set_student_assignment
    @student_assignment = current_student.student_assignments.find_by(id: params[:id])
    redirect_to root_path, notice: 'Unauthorized.' if @student_assignment.nil?
  end
end
