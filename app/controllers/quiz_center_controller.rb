class QuizCenterController < ApplicationController
  before_action :authenticate_user!

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
end
