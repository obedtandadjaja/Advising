class UsersConcentration < ActiveRecord::Base

	belongs_to :user
	belongs_to :concentration
	
end
