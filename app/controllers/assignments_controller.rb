class AssignmentsController < ApplicationController
  before_action :authenticate_teacher!
  ## CREATE/DESTROY
  before_action :set_course, only: [:create, :destroy]
  before_action :correct_teacher_course, only: [:create, :destroy]
  ## EDIT
  before_action :correct_teacher_edit, only: [:edit, :update]

  def create
    due_date = Time.parse(params['assignment']['due_date'] + "12:00:00 AM")
    validator = AssignmentValidator.check(@course.id, due_date, params['assignment']['category'])

    if validator == 1
      # status code 1 means you can proceed, with no warnings.
      @assignment = Assignment.create(category: params['assignment']['category'],
                                      course_id: @course.id,
                                      description: params['assignment']['description'],
                                      due_date: due_date,
                                      name: params['assignment']['name'])
      AssignmentCreatorWorker.perform_async(@assignment.id)
      render json: {}, status: 200
    elsif validator == 2
      # status code 2 means you can proceed, but with a warning
      # will return HTTP code 409 (Conflict)
      @assignment = Assignment.create(category: params['assignment']['category'],
                                      course_id: @course.id,
                                      description: params['assignment']['description'],
                                      due_date: due_date,
                                      name: params['assignment']['name'])
      AssignmentCreatorWorker.perform_async(@assignment.id)
      render json: {}, status: 409
    elsif validator == 3
      # status code 3 means you cannot proceed, with a warning
      # will return HTTP code 412 (Precondition Failed)
      render json: {}, status: 412
    end
  end

  def edit
  end

  def update
    due_date = Time.parse(assignment_params['due_date'] + "12:00:00 AM")
    @assignment.update!(#category: assignment_params['category'],
                          description: assignment_params['description'],
                          due_date: due_date,
                          name: assignment_params['name'])
    @assignment.save!
    redirect_to course_path(@assignment.course), notice: 'Assignment saved.'
  end

  def destroy
    @assignment = Assignment.find_by(id: params[:assignment_id])
    @assignment.destroy
    redirect_to course_path(@course)
  end

  private

  def assignment_params
    params.require(:assignment).permit(:description, :due_date, :name)
  end

  def correct_teacher_course
    @course = current_teacher.courses.find_by(id: params[:course_id])
    render :json => {}, status: 422 if @course.nil?
  end

  def correct_teacher_edit
    @assignment = Assignment.find_by(id: params[:assignment_id])
    if !current_teacher.courses.where(id: @assignment.course.id).any?
      redirect_to root_path, notice: 'Unauthorized.'
    end
  end

  def set_course
    @course = Course.find_by(id: params[:course_id])
    render :json => {}, status: 422 if @course.nil?
  end
end
