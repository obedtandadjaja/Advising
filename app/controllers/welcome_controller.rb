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

	before_filter :authorize, :set_semesters
	respond_to :js, :json, :html

	def set_semesters
	    @semesters = Array.new
	    counter = @current_user.enrollment_time
	    counter_limit = @current_user.graduation_time
	    while counter <= counter_limit do
	      @semesters << "#{counter}s"
	      @semesters << "#{counter}f"
	      counter = counter+1
	    end
	    @semesters.pop
	    @semesters.shift
	end

	def index
		@user = @current_user
		@distributions = Distribution.order(:title)
		@majors = @user.major
		@minors = @user.minor
		@concentration = @user.concentration
		@courses = @user.course

		@user_semester_hours = getSemesterHours
	end
	
	def advising_ajax
		@user = @current_user
		@course = Course.find(params[:id])

		checkPrerequisitesArray = checkPrerequisites(@user, @course)
		if(checkPrerequisitesArray.count == 0)
			@user_course = UsersCourse.new(user_id: @user.id, course_id: @course.id, taken_planned: params[:date])
			@user_course.save
			@user_courses_hash = getSemesterCourses

			respond_to do |format|
		    	format.html
		    	format.json { render json: @user_courses_hash.to_json }
		    	format.js
		    end
		else
			respond_to do |format|
				format.html
				format.json { render json: { :error => true, :error_messages => checkPrerequisitesArray } }
				format.js
			end
		end
	end

	def checkPrerequisites(user, course)
		errors = Array.new
		course.prerequisite.each do |prereq|
			prerequisite = UsersCourse.where(user_id: user.id, course_id: prereq.id).first
			if(prerequisite)
				prerequisite_taken_on = @semesters.index(prerequisite.taken_planned)
				course_taken_on = @semesters.index(params[:date])
				if(prerequisite_taken_on > course_taken_on)
					errors << "Prerequisite: #{prereq.subject} #{prereq.course_number} for #{course.subject} #{course.course_number} must be taken earlier"
				end
			else
				errors << "Prerequisite: #{prereq.subject} #{prereq.course_number} for #{course.subject} #{course.course_number} not taken"
			end
		end
		return errors
	end

	def getSemesterCourses
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
		return @user_courses_hash
	end

	def getSemesterHours
		@user_courses_hash = getSemesterCourses
		@user_semester_hours = Hash.new
		@user_courses_hash.each do |key, array|
			@user_semester_hours["#{key}"] = 0
			array.each do |course|
				@user_semester_hours["#{key}"] += course.hr_low
			end
		end
		return @user_semester_hours
	end

end