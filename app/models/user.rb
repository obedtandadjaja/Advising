class User < ActiveRecord::Base

	has_many :users_course

  	has_secure_password

  	validates :password, :presence => true,
    	:confirmation => true,
    	:length => {:within => 6..40},
    	:on => :create
  	validates :email, :presence => true, :uniqueness => true

  	validates_confirmation_of :password

end
