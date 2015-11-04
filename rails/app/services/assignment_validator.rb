class AssignmentValidator
  def self.check(course_id, due_date, category)
    if category == "Homework"
      return 1
    end

    @course = Course.find(course_id)
    @due_date = due_date
    @students = @course.students.all

    number_of_assignments = []
    @students.each do |student|
      quiz_count = student.student_assignments.joins(:assignment).where(assignments: { category: "Quiz", due_date: @due_date }).all.count || 0
      project_count = student.student_assignments.joins(:assignment).where(assignments: { category: "Project", due_date: @due_date }).all.count || 0
      test_count = student.student_assignments.joins(:assignment).where(assignments: { category: "Test", due_date: @due_date }).all.count || 0
      student_num_of_assignments = quiz_count + project_count + test_count
      number_of_assignments << student_num_of_assignments
    end

    counts = Hash.new(0)
    number_of_assignments.each do |assignment|
      counts[assignment] += 1
    end

    if counts[2] > (@students.count * 0.75) or counts[3] > (@students.count * 0.50) or counts.any?{ |k,v| k > 3 }
      return 3
    elsif counts[2] > (@students.count * 0.50)
      return 2
    else
      return 1
    end
  end
end
