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

class WelcomeController < ApplicationController

	before_filter :authorize, :set_courses, :set_hours
	respond_to :js, :json, :html

	def set_courses
		@courses = []
	end

	def set_hours
		@hours = 0
	end

	before_filter :authorize
	
	def index
		@user = User.find(session[:user_id])
		@distributions = Distribution.order(:title)
		@majors = @user.major
		@minors = @user.minor
		@concentration = @user.concentration
		@courses = @user.course

		@semesters = Array.new
		counter = @user.enrollment_time
		while counter <= @user.graduation_time do
			@semesters << "#{counter}s"
			@semesters << "#{counter}f"
			counter = counter+1
		end
		@semesters.pop
		@semesters.shift

		@courses.each do |course|
			@hours += course.hr_low
		end
	end
	
	def advising_ajax
		@user = User.find(session[:user_id])
		@course = Course.find(params[:id])
		@user_course = UsersCourse.new(user_id: @user.id, course_id: @course.id, taken_planned: params[:date])
		@user_course.save
		@user_courses = UsersCourse.where(user_id: @user.id)
		@user_courses_hash = Hash.new
		@user_courses.each do |course|
			if(@user_courses_hash.has_key?(course.taken_planned))
				@user_courses_hash["#{course.taken_planned}"] << Course.find(course.course_id)
			else
				@user_courses_hash["#{course.taken_planned}"] = Array.new
				@user_courses_hash["#{course.taken_planned}"] << Course.find(course.course_id)
			end
		end
		
		respond_to do |format|
	      format.html
	      format.json { render json: @user_courses_hash.to_json }
	      format.js
	    end
	end
end
