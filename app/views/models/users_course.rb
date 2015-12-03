class UsersCourse < ActiveRecord::Base
	belongs_to :course
	belongs_to :user

	def self.search(banner_id, id)
	    where("id like ?", "%#{id}%")
  	end
  	
end
