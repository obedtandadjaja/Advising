#lib/tasks/report.rake
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
#usage: rake db:create_report[student_email,text_file.txt]
#note that there are no spaces around the comma
#if there are spaces around the comma the command won't run
#creates a text file report for the student specified where the information is organized by semester

#regarding the word file output: you can use .txt or .doc, but .doc has plain text font

desc "Prints out a summary of a user's info and planned schedule to a text file"
namespace :db do   
task :report, [:arg1, :arg2] => :environment do |t,args|
		user = User.find_by email: args[:arg1]  #find user info based on email
		
		File.open(args[:arg2],'w') do |line|
			line.puts "Schedule for #{ user.name }"
			line.puts user.email
			if user.banner_id
				line.puts user.banner_id  #prints nothing if it doesn't have it
			end
			if user.enrollment_time
				line.puts "Enrolled: #{ user.enrollment_time }\n"
			end
			
			@courses = Course.joins(users_course: :user ).where(  
				users_courses: { user_id: user.id }).order("users_courses.taken_planned")
				
			t = ""
			@courses.each do |cor|
				tim = UsersCourse.find_by course_id:cor.id
				
				if (tim.taken_planned != t) 
					t = tim.taken_planned
					if t == nil
						line.print "\nNot Scheduled Yet\n"
					else
						if t[4] == 'f'
							line.print "\nFall #{t[0,4] }\n"
						else
							line.print "\nSpring #{ t[0,4] }\n"
						end
					end
				end
				line.print "#{ cor.title } \n"
				
			end
			line.puts ""
			
		end
	end	
end