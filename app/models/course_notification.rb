class CourseNotification < ActiveRecord::Base
  belongs_to :course

  validates_presence_of :body
  validates_presence_of :subject
end
