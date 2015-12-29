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
	has_many :concentration, -> { uniq }, through: :concentrations_course

	has_many :distributions_course
	has_many :distribution, -> { uniq }, through: :distributions_course

	has_many :majors_course
	has_many :major, -> { uniq }, through: :majors_course

	has_many :users_course
	has_many :user, -> { uniq }, through: :users_course

	has_many :minors_course
	has_many :minor, -> { uniq }, through: :minors_course

	has_many :course_prerequisite
	has_many :prerequisite, -> { uniq }, through: :course_prerequisite

	# make sure that all the form inputs are filled in
	validates :subject, :presence => true
	validates :course_number, :presence => true, :numericality => true
	validates :title, :presence => true
	validates :hr_low, :presence => true, :numericality => true

  	validates_numericality_of :hr_low

end

