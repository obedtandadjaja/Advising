#lib/tasks/report.rake
#usage: rake db:create_report[student_email,text_file.txt]
#creates a text file report for the student specified

#regarding the word file output: you can use .txt or .doc, but .doc has simple font

desc "Prints out a summary of a user's info and planned schedule to a text file"
namespace :db do   
task :report, [:arg1, :arg2] => :environment do |t,args|

		user = User.find_by email: args[:arg1]  #find user info based on name
		
		File.open(args[:arg2],'w') do |line|
			line.puts "Schedule for #{ user.name }"
			line.puts user.email
			line.puts user.banner_id  #prints nothing if it doesn't have it
			
			#check that it's actually only picking up courses I'm in
			@majors = Course.joins(majors_course: :major, users_course: :user ).where(
				users_courses: { user_id: user.id }).order("users_courses.taken_planned")
				
			t = ""
			@majors.each do |cor|
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