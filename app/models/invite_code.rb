class InviteCode < ActiveRecord::Base
  before_save :generate_course_code
  validates_uniqueness_of :code

  private

  def generate_course_code
    code = SecureRandom.hex(4)
    if InviteCode.find_by(code: code) != nil
      generate_course_code
    else
      self.code ||= code
    end
  end
end
