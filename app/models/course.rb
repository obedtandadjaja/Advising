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
	validates :title, :presence => true
	validates :subject, :presence => true
	validates :number, :presence => true
	validates :credit, :presence => true
	# validates :dateOffered, :presence => true
  	validates :crn, :presence => true, :uniqueness => true

  	validates_numericality_of :number
  	validates_numericality_of :credit
  	validates_numericality_of :crn

end
