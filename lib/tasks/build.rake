#lib/tasks/build.rake
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
#usage: rake db:build

namespace :db do
	task :build, [] => :environment do |t|

		Rake::Task["db:create"].invoke
		Rake::Task["db:migrate"].invoke
		Rake::Task["db:load_courses"].invoke
		Rake::Task["db:load_cos_concentrations"].invoke
		Rake::Task["db:load_distributions"].invoke
		Rake::Task["db:load_cos_major"].invoke
		Rake::Task["db:load_cos_minor"].invoke
		Rake::Task["db:load_cos_prerequisites"].invoke

	end
end
