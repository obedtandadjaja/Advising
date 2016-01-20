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
#caveat: first record of csv file must be table record names in lowercase letters

require 'csv'
desc "Imports a CSV file into an ActiveRecord table"
namespace :db do
	# speed up bulk import with transaction, multiple inserts, and handling uniqueness from model
	task load_courses: :environment do |t|
	  	require 'csv'
	  	require 'active_record'
		require 'activerecord-import'

		csv = CSV.read("courses.csv")
    	# ignores the csv header
    	csv.shift

	  	Course.transaction do
	    	course_columns = [:subject,:course_number,:title,:department_code,:cipc_code,:hr_low,:hr_high,:department_desc]
	    	Course.import course_columns, csv, validate: true
	  	end
	end
end

