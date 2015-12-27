#lib/tasks/import_cos_minor.rake
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
#usage: rake db:load_cos_minor
#caveat: first row of csv file must be table row names in lowercase letters

namespace :db do
	task :load_cos_minor, [] => :environment do |t|
		csv_text = File.read("COS_minor_courses.csv")
		csv = CSV.parse(csv_text, :headers => true)
		csv.each do |row|
			
			# if minor does not exist, make one
			Minor.create_with(
				:total_hours => 126
			)
			.find_or_create_by(
				:name => row[2],
			)

			# make concentration-course relation
			MinorsCourse.find_or_create_by(
				:course_id => Course.where(subject: row[0], course_number: row[1]).first.id,
				:minor_id => Minor.where(name: row[2]).first.id
			)

		end
	end
end
