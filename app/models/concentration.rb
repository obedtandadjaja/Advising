class Concentration < ActiveRecord::Base
	belongs_to :major
	has_many :concentrations_course, dependent: :destroy
	has_many :course, through: :concentrations_course
end
