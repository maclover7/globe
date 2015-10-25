class StudentAssignment < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :student

  ## SCOPES
  scope :no_ia, -> { joins(:assignment).where("assignments.category != ?", "Interactive Assessment") }
  scope :uncompleted, -> { where(completed: false) }

  ## ASSIGNMENT HELPERS
  def self.due_for_course(student, course_id)
    student.student_assignments.uncompleted.joins(:assignment).where("assignments.course_id = ?", course_id).no_ia.all
  end

  def self.due_for_time(student, time)
    if time == 'overdue'
      student.student_assignments.uncompleted.joins(:assignment).where("assignments.due_date <= ?", Date.today).no_ia.all
    elsif time == 'today'
      student.student_assignments.uncompleted.joins(:assignment).where("DATE(assignments.due_date) = ?", Date.today).no_ia.all
    elsif time == 'tomorrow'
      student.student_assignments.uncompleted.joins(:assignment).where("DATE(assignments.due_date) = ?", Date.tomorrow).no_ia.all
    elsif time == 'this_week'
      student.student_assignments.uncompleted.joins(:assignment).where("DATE(assignments.due_date) BETWEEN ? AND ?", Date.today.beginning_of_week, Date.today.end_of_week).no_ia.all
    elsif time == 'next_2_weeks'
      student.student_assignments.uncompleted.joins(:assignment).where("DATE(assignments.due_date) BETWEEN ? AND ?", Date.today.beginning_of_week, Date.today.end_of_week + 7.days).no_ia.all
    elsif time == 'all'
      student.student_assignments.uncompleted.no_ia.all
    end
  end
end
