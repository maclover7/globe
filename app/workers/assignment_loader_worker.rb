class AssignmentLoaderWorker
  include Sidekiq::Worker

  def perform(course_id, student_id)
    @course = Course.find(course_id)
    @student = Student.find(student_id)
    @assignments = @course.assignments.where("DATE(assignments.due_date) >= ?", Date.today).all
    @assignments.each do |assignment|
      StudentAssignment.create(assignment_id: assignment.id, student_id: @student.id)
      puts 'StudentAssignment +1'
    end
  end
end
