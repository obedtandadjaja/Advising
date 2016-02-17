#
#   Copyright 2015 Amy Dewaal and Obed Tandadjaja
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

	enum role: [ :student, :admin, :teacher ]

	has_many :users_course, dependent: :destroy
	has_many :course, through: :users_course

	has_many :users_major
	has_many :major, through: :users_major

	has_many :users_minor
	has_many :minor, through: :users_minor

	has_many :users_concentration
	has_many :concentration, through: :users_concentration

	email_regex = /\A[\w+\-.]+@covenant\.edu\z/i

	validates :email,
		:presence => true,
		:uniqueness => true,
		:format => { :with => email_regex, :message => ": Please enter your Covenant email address" }
	validates :password,
	  	:length => {:within => 6..40},
	  	:if => :password

	with_options :if => :is_student? do |u|
		u.validates :name,
			:presence => true
		u.validates :banner_id,
			:presence => true,
			:uniqueness => true,
			:length => {:is => 8},
			:numericality => true
		u.validates :enrollment_time,
			:presence => true,
			:length => {:is => 4},
			inclusion: { in: Date.today.year-5..Date.today.year }
		u.validates :graduation_time,
			:presence => true,
			:length => {:is => 4},
			inclusion: { in: Date.today.year..Date.today.year+5}
	end

  	# before_create { generate_token(:auth_token) }

  	def is_student?
  		self.role == "student"
  	end

  	# def generate_token(column)
   #  	begin
   #    	self[column] = SecureRandom.urlsafe_base64
   #  	end while User.exists?(column => self[column])
  	# end

  	# def send_password_reset
   #  	generate_token(:password_reset_token)
   #  	self.password_reset_sent_at = Time.zone.now
   #  	save!
   #  	UserMailer.password_reset(self).deliver
  	# end

  	# def send_invite
  	# 	UserMailer.invite(self).deliver
  	# end

end
