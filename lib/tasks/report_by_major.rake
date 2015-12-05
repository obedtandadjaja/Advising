#lib/tasks/report_by_major.rake
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
#usage: rake db:create_report[student_email,text_file]
#creates a text file report for the student specified grouped by major

#regarding the word file output: you can use .txt or .doc, but .doc has simple font

desc "Prints out a summary of a user's info organized by major to a text file"
namespace :db do   
task :report_by_major, [:arg1, :arg2] => :environment do |t,args|
		user = User.find_by email: args[:arg1]  #find user info based on email
		
		File.open(args[:arg2],'w') do |line|
			line.puts "Schedule for #{ user.name }"
			line.puts user.email
			line.puts user.banner_id  #prints nothing if it doesn't have it
			
			UsersMajor.where(user_id: user.id).find_each do |um| #get major id(s) (could be double major)
				major = Major.find_by id: um.major_id #get major name from major table
				line.print "Major: #{ major.name} \n"
				line.puts "Courses: "
			
				Course.joins(:users_course, :majors_course).where(['users_courses.user_id = ? 
					AND majors_courses.major_id = ? ',user.id, major.id]).find_each do |cor|
					
					tim = UsersCourse.find_by course_id:cor.id
	
					line.print "#{ cor.title }, "
					if tim.taken_on != nil
						line.puts "taken on #{ tim.taken_on }"
					else 
						line.puts "not taken yet"
					end
				
				end
				line.puts ""
			end
			
		end
		
	end
end