class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :student_assignments, dependent: :destroy
  validates_presence_of :description
  validates_presence_of :name
end
