class Concentration < ActiveRecord::Base
	belongs_to :major
	has_many :concentrations_course
end
