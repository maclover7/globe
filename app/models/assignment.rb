class Assignment < ActiveRecord::Base
  belongs_to :course
  validates_presence_of :description
  validates_presence_of :name
end
