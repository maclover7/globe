class StudentAssignment < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :student

  ## ASSIGNMENT HELPERS
  def self.due_for_course(student, course_id)
    student.student_assignments.where(completed: false).joins(:assignment).where("assignments.course_id = ?", course_id).all
  end
  
  def self.due_for_time(student, time)
    if time == 'overdue'
      student.student_assignments.where(completed: false).joins(:assignment).where("assignments.due_date <= ?", Date.today).all
    elsif time == 'today'
      student.student_assignments.where(completed: false).joins(:assignment).where("DATE(assignments.due_date) = ?", Date.today).all
    elsif time == 'tomorrow'
      student.student_assignments.where(completed: false).joins(:assignment).where("DATE(assignments.due_date) = ?", Date.tomorrow).all
    elsif time == 'this_week'
      student.student_assignments.where(completed: false).joins(:assignment).where("DATE(assignments.due_date) BETWEEN ? AND ?", Date.today.beginning_of_week, Date.today.end_of_week).all
    elsif time == 'next_2_weeks'
      student.student_assignments.where(completed: false).joins(:assignment).where("DATE(assignments.due_date) BETWEEN ? AND ?", Date.today.beginning_of_week, Date.today.end_of_week + 7.days).all
    elsif time == 'all'
      student.student_assignments.where(completed: false).all
    end
  end
end
