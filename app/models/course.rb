class Course < ActiveRecord::Base
	has_many :concentrations_course
	has_many :concentration, through: :concentrations_course

	has_many :distributions_course
	has_many :distribution, through: :distributions_course

	has_many :majors_course
	has_many :major, through: :majors_course

	has_many :users_course
	has_many :user, through: :users_course

	has_many :minors_course
	has_many :minor, through: :minors_course

	# make sure that all the form inputs are filled in
	validates :subject, :presence => true
	validates :course_number, :presence => true
	validates :title, :presence => true
	validates :hr_low, :presence => true

  	validates_numericality_of :hr_low

end

