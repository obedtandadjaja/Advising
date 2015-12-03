class MinorsCourse < ActiveRecord::Base

	belongs_to :minor
	belongs_to :course
	belongs_to :user
	
end
