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
class Course < ActiveRecord::Base
	has_many :concentrations_course
	has_many :concentration, through: :concentrations_course

	has_many :distributions_course
	has_many :distribution, through: :distributions_course

	has_many :majors_course
	has_many :major, through: :majors_course

	has_many :users_course
	has_many :user, through: :users_course

	has_many :minors_course
	has_many :minor, through: :minors_course

	# make sure that all the form inputs are filled in
	validates :subject, :presence => true
	validates :course_number, :presence => true
	validates :title, :presence => true
	validates :hr_low, :presence => true
	validates :dateOffered, :presence => true
  	validates :crn, :presence => true, :uniqueness => true

  	validates_numericality_of :course_number
  	validates_numericality_of :hr_low
  	validates_numericality_of :crn

end

