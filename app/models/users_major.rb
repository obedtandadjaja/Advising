class UsersMajor < ActiveRecord::Base
	belongs_to :major
	belongs_to :user
end
