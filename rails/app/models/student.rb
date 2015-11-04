class Student < User
  has_many :courses, through: :enrollments
  has_many :enrollments, dependent: :destroy
  has_many :student_assignments, dependent: :destroy
end
