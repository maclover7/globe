class CoursesController < ApplicationController
  before_action :authenticate_teacher!, except: :show
  before_action :authenticate_user!
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :correct_teacher, only: [:edit, :update, :destroy]
  before_action :correct_user, only: :show

  # GET /courses
  # GET /courses.json
  def index
    @courses = current_teacher.courses.all
  end

  # GET /courses/1
  def show
    @assignments = @course.assignments.where("DATE(assignments.due_date) >= ?", Date.today).all
  end

  # GET /courses/new
  def new
    @course = current_teacher.courses.build
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  def create
    @course = current_teacher.courses.build(course_params)

    if @course.save
      redirect_to @course, notice: 'Course was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /courses/1
  def destroy
    if @course.destroy
      render json: {}, status: 200
    else
      render json: {}, status: 500
    end
  end

  private
    def correct_teacher
      @course = current_teacher.courses.find_by(id: params[:id])
      redirect_to root_path, 'You do not have permission to view/edit this course' if @course.nil?
    end

    def correct_user
      @course = current_user.courses.find_by(id: params[:id])
      redirect_to root_path, 'You do not have permission to view/edit this course' if @course.nil?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:description, :name, :teacher_id)
    end
end
