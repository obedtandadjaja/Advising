class UsersCourse < ActiveRecord::Base
	belongs_to :course
	belongs_to :user

	def self.search(banner_id, id)
	    # where(:title, query) -> This would return an exact match of the query
	    where("id like ?", "%#{id}%")
  	end
end
