class Minor < ActiveRecord::Base

	has_many :minors_course, dependent: :destroy
	has_many :course, through: :minors_course
	
	has_many :users_minor

end
