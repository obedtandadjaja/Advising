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
