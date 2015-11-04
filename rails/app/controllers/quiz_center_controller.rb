class QuizCenterController < ApplicationController
  before_action :authenticate_user!
  # Students
  before_action :authenticate_student!, only: [:take, :update]
  before_action :set_student_assignment, only: [:take, :update]
  before_action :correct_student, only: [:take, :update]
  # Teachers
  before_action :authenticate_teacher!, only: [:change_start_status, :manage]
  before_action :set_assignment, only: [:change_start_status, :manage]
  before_action :correct_teacher, only: [:change_start_status, :manage]


  def change_start_status
    if @assignment.started == true
      @assignment.update!(started: false)
      # Alert Pusher (and students) to stop work
      Pusher.trigger("assignment-#{ENV['RAILS_ENV'] || ENV['RACK_ENV']}-#{@assignment.id}", 'stop-work', {})
      render :json => {}, :status => 200
    else
      @assignment.update!(started: true)
      # Alert Pusher (and students) to start work
      Pusher.trigger("assignment-#{ENV['RAILS_ENV'] || ENV['RACK_ENV']}-#{@assignment.id}", 'start-work', {})
      render :json => {}, :status => 200
    end
  end

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

  def take
  end

  def update
    if @assignment.update(student_assignment_params)
      render json: {}, status: 200
    end
  end

  private

  def correct_student
    if @assignment.student_id != current_student.id
      redirect_to(root_path, notice: 'You do not have permission to view/edit this assignment') and return
    end
  end

  def correct_teacher
    if @assignment.course.teacher_id != current_teacher.id
      redirect_to root_path, notice: 'You do not have permission to view/edit this assignment'
    end
  end

  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  def set_student_assignment
    @assignment = StudentAssignment.find(params[:id])
  end

  def student_assignment_params
    params.require(:student_assignment).permit(:response)
  end
end
