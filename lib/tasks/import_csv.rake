#lib/tasks/import_csv.rake
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

