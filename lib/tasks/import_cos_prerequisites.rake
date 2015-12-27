#lib/tasks/import_cos_prerequisites.rake
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
#usage: rake db:load_cos_prerequisites
#caveat: first row of csv file must be table row names in lowercase letters

namespace :db do
	task :load_cos_prerequisites, [] => :environment do |t|
		csv_text = File.read("COS_courses_prerequisites.csv")
		csv = CSV.parse(csv_text, :headers => true)
		csv.each do |row|
			
			course = Course.where(subject: row[0], course_number: row[1]).first
			prerequisite = Course.where(subject: row[2], course_number: row[3]).first
			CoursePrerequisite.find_or_create_by(course_id: course.id, prerequisite_id: prerequisite.id)

		end
	end
end
