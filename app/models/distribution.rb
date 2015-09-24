class Distribution < ActiveRecord::Base
	has_many :distributions_course

	validates :title, :presence => true, :uniqueness => true
end
