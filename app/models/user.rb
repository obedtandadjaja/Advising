class User < ActiveRecord::Base

	has_many :users_course, dependent: :destroy
	has_many :course, through: :users_course

	has_many :users_major
	has_many :major, through: :users_major

	has_many :users_minor
	has_many :minor, through: :users_minor

	has_many :users_concentration
	has_many :concentration, through: :users_concentration

  	has_secure_password

  	validates :password, :presence => true,
    	:confirmation => true,
    	:length => {:within => 6..40},
    	:on => :create, :if => :password
  	validates :email, :presence => true, :uniqueness => true

end
