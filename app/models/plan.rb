class Plan < ActiveRecord::Base

	has_many :plans_course, dependent: :destroy
	has_many :course, through: :plans_course

	has_many :users_plan, dependent: :destroy
	has_many :user, through: :users_plan

	def self.search(banner_id, id)
	    where("id like ?", "%#{id}%")
  	end
end
