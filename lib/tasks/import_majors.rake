#lib/tasks/import_majors.rake
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
#usage: rake db:load_majors
#caveat: first record of csv file must be table record names in lowercase letters

require 'csv'
desc "Imports a CSV file into an ActiveRecord table"
namespace :db do
	task :load_majors, [] => :environment do |t|
		csv_text = File.read("courses.csv")
		csv = CSV.parse(csv_text, :headers => true)

		csv.each do |record|
			Major.find_or_create_by(
				:name => record[0],
				:department => record[7],
				:total_hours => 126
			)
		end
	end
end

