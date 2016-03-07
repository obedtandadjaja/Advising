class Plan < ActiveRecord::Base
	belongs_to :course
	belongs_to :user

	has_many :plans_course, dependent: :destroy
	has_many :course, through: :plans_course

	def self.search(banner_id, id)
	    where("id like ?", "%#{id}%")
  	end
end
