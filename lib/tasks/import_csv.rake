#lib/tasks/import_csv.rake
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
#usage: rake db:load_courses
#caveat: first row of csv file must be table row names in lowercase letters

require 'csv'
desc "Imports a CSV file into an ActiveRecord table"
namespace :db do
task :load_courses, [] => :environment do |t|
		csv_text = File.read("courses.csv")
		csv = CSV.parse(csv_text, :headers => true)
		courses_table = "courses".classify.constantize

		csv.each do |row|

			# order is the same
			courses_table.create!(row.to_hash)
			
			# unique by name
			Major.find_or_create_by(
				:name => row[0],
				:department => row[7],
				:total_hours => 126
			)

			# unique by name
			Minor.create_with(
				:department => row[7],
				:total_hours => 52
			)
			.find_or_create_by(
				:name => row[0]
			)
		end
	end
end

