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
    @students = @assignment.course.students.all
  end

  def pusher_auth
    if current_user
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
        :user_id => current_user.id,
        :user_info => {
          :name => current_user.name,
          :email => current_user.email,
          :role => current_user.class.to_s
        }
      })
      render :json => response
    else
      render :text => "Forbidden", :status => '403'
    end
  end

  def change_start_status
    set_assignment
    if @assignment.started == true
      @assignment.update!(started: false)
      render :json => {}, :status => 200
    else
      @assignment.update!(started: true)
      render :json => {}, :status => 200
    end
  end

  def take
    set_student_assignment
  end

  private

  def set_assignment
    @assignment = Assignment.find(params[:id])
    unless @assignment.course.teacher_id == current_teacher.id
      redirect_to root_path, notice: 'You do not have permission to view/edit this assignment'
    end
  end

  def set_student_assignment
    @assignment = StudentAssignment.find(params[:id])
    unless current_student.enrollments.where(course_id: @assignment.assignment.course_id).any?
      redirect_to root_path, notice: 'You do not have permission to view/edit this assignment'
    end
  end
end
