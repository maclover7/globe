class DashboardController < ApplicationController
  before_action :authenticate_student!

  def index
    @student = current_student
    @courses = current_student.courses
    #
    ## Per Time Period:
    if params[:time] == "overdue"
      @page_heading = "Overdue Assignments:"
      @student_assignments = StudentAssignment.due_for_time(current_student, 'overdue')
    elsif params[:time] == "today"
      @page_heading = "Today's Assignments:"
      @student_assignments = StudentAssignment.due_for_time(current_student, 'today')
    elsif params[:time] == "tomorrow"
      @page_heading = "Tomorrow's Assignments:"
      @student_assignments = StudentAssignment.due_for_time(current_student, 'tomorrow')
    elsif params[:time] == "week"
      @page_heading = "This Week's Assignments:"
      @student_assignments = StudentAssignment.due_for_time(current_student, 'this_week')
    elsif params[:time] == "next_2_weeks"
      @page_heading = "Next 2 Week's Assignments"
      @student_assignments = StudentAssignment.due_for_time(current_student, 'next_2_weeks')
    elsif params[:time] == "all"
      @page_heading = "All Assignments:"
      @student_assignments = StudentAssignment.due_for_time(current_student, 'all')
    end

    ## Per Course:
    if params[:course_id]
      if @course = current_student.courses.find_by_id(params[:course_id])
        @page_heading = "#{@course.name} Assignments:"
        @student_assignments = StudentAssignment.due_for_course(current_student, @course.id)
      else
        redirect_to student_root_path, notice: "Not authorized to view assignments for this course" if @course.nil?
      end
    end
    #
    @overdue_assignments = StudentAssignment.due_for_time(current_student, 'overdue')
    @today_assignments = StudentAssignment.due_for_time(current_student, 'today')
    @tomorrow_assignments = StudentAssignment.due_for_time(current_student, 'tomorrow')
    @week_assignments = StudentAssignment.due_for_time(current_student, 'this_week')
    @next_2_weeks_assignments = StudentAssignment.due_for_time(current_student, 'next_2_weeks')
    @all_assignments = StudentAssignment.due_for_time(current_student, 'all')
  end
end
