class QuizCenterController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_student!, only: [:take]
  before_action :authenticate_teacher!, only: [:manage]

  def index
    if student_signed_in? # student
      @assessments = current_student.student_assignments.where(completed: false).joins(:assignment).where("assignments.category = ?", "Interactive Assessment" ).all || []
    else # teacher
      @assessments = []
      current_teacher.courses.each do |course|
        @assessments += course.assignments.where(category: "Interactive Assessment").all
      end
    end
  end

  def manage
    set_assignment
  end

  def take
    set_student_assignment
  end

  private

  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  def set_student_assignment
    @assignment = StudentAssignment.find(params[:id])
  end
end
