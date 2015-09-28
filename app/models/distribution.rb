class Distribution < ActiveRecord::Base
	has_many :distributions_course, dependent: :destroy
	has_many :course, through: :distributions_course

	validates :title, :presence => true, :uniqueness => true
end
