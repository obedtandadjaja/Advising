class ConcentrationsCourse < ActiveRecord::Base
	belongs_to :concentration
	belongs_to :course
end
