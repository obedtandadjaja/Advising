class MajorsCourse < ActiveRecord::Base
	belongs_to :major
	has_many :course
end
