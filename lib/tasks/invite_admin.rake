#lib/tasks/invite_admin.rake
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
#usage: rake db:invite_admin[admin_email]

desc "Invites a user to the app"
namespace :db do
	task :invite_admin, [:arg1] => :environment do |t,args|
		require 'securerandom'

		new_user = User.create_with(
			:password => SecureRandom.uuid,
			:role => "admin"
		)
		.find_or_create_by(
			:email => args[:arg1]
		)
		new_user.save!

		UserMailer.invite(new_user).deliver
	end
end