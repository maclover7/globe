class Course < ActiveRecord::Base
  before_save :generate_course_code

  belongs_to :teacher
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
