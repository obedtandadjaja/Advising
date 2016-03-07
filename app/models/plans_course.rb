class PlansCourse < ActiveRecord::Base
	belongs_to :plan
	belongs_to :course
end
