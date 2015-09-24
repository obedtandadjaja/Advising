class DistributionsCourse < ActiveRecord::Base
	has_many :course
	belongs_to :distribution
end
