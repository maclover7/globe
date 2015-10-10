class Course < ActiveRecord::Base
  has_many :assignments, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments
  belongs_to :teacher
  ###
  before_save :generate_course_code
  validates_presence_of :name

  private

  def generate_course_code
    code = SecureRandom.hex(4)
    if Course.find_by(code: code) != nil
      generate_course_code
    else
      self.code ||= code
    end
  end
end
