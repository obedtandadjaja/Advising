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
#usage: rake db:load_table[csv_filename,table_name]
#caveat: first row of csv file must be table row names in lowercase letters

require 'csv'
desc "Imports a CSV file into an ActiveRecord table"
namespace :db do   
task :load_table, [:arg1, :arg2] => :environment do |t,args|
		csv_text = File.read(args[:arg1])
		csv = CSV.parse(csv_text, :headers => true)
		model = args[:arg2].classify.constantize
		csv.each do |row|
		model.create!(row.to_hash)  
		end
	end
end

