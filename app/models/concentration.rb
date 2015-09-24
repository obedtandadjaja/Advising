class Concentration < ActiveRecord::Base
	belongs_to :major
	has_many :concentrations_course
	has_many :course, through: :concentrations_course
end
