#lib/tasks/invite_teacher.rake
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
#usage: rake db:invite_teacher[teacher_email,teacher_major]

desc "Invites a user to the app"
namespace :db do
	task :invite_teacher, [:arg1,:arg2] => :environment do |t,args|
		require 'securerandom'

		if !User.find_by_email(args[:arg1])
			# assume that if major exists then minor must also exist
			major = Major.find_by_name(args[:arg2])
			minor = Minor.find_by_name(args[:arg2])
			if (major && minor)
				new_user = User.create_with(
					:password => SecureRandom.uuid,
					:role => "admin"
				)
				.find_or_create_by(
					:name => args[:arg1],
					:email => args[:arg1]
				)
				new_user.save!

				new_user.major << major
				new_user.minor << minor

				UserMailer.invite(new_user).deliver
			else
				puts "Error: Invalid Major/Minor!"
			end
		else
			puts "Error: Email has been taken!"
		end
	end
end