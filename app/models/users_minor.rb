class UsersMinor < ActiveRecord::Base
	belongs_to :minor
	belongs_to :user
end
