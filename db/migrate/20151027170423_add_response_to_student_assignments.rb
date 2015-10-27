class AddResponseToStudentAssignments < ActiveRecord::Migration
  def change
    add_column :student_assignments, :response, :text
  end
end
