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

class Minor < ActiveRecord::Base

	has_many :minors_course, dependent: :destroy
	has_many :course, through: :minors_course
	
	has_many :users_minor
	has_many :user, through: :users_minor

	validates :name, :presence => true, :uniqueness => true
	validates :total_hours, :presence => true

  	validates_numericality_of :total_hours

end
