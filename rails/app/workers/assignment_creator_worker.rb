class AssignmentCreatorWorker
  include Sidekiq::Worker

  def perform(assignment_id)
    @assignment = Assignment.find(assignment_id)
    @students = @assignment.course.students

    @students.each do |student|
      StudentAssignment.create(assignment_id: @assignment.id, student_id: student.id)
      puts 'StudentAssignment +1'
    end
  end
end
