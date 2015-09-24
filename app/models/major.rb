class Major < ActiveRecord::Base
	has_many :concentration
	has_many :majors_course
	has_many :course, through: :majors_course

	# make sure that all the form inputs are filled in
	validates :name, :presence => true, :uniqueness => true
	validates :total_hours, :presence => true

  	validates_numericality_of :total_hours
  	
end
