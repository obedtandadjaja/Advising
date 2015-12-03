class DistributionsCourse < ActiveRecord::Base
	belongs_to :course
	belongs_to :distribution
end
