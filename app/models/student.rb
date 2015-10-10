class Student < User
  has_many :courses, through: :enrollments
  has_many :enrollments, dependent: :destroy
end
