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

class AdvisingController < ApplicationController

	before_filter :authorize, :set_semesters
	respond_to :js, :json, :html

	# based on the student's enrollment time and graduation time, get the semesters
	# he or she will be attending. Not the best algorithm but it works
	def set_semesters
		if is_student
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
	end

	# displays the current class schedule of user
	def index
		if is_admin
			@students = User.where(role: "student")
		elsif is_teacher
			@students = User.where(role: "student")
			# @current_user.major.each do |major|
			# 	@students += major.user.where(role: 'student')
			# end
		else
			@user = @current_user
			@distributions = Distribution.order(:title)
			@majors = @user.major
			@minors = @user.minor
			@concentration = @user.concentration
			@courses = @user.course
			@user_semester_hours = get_semesters_hours
			@completion_hash = check_completion(@user)
		end
	end
	
	# drag and drop course ajax is handled here
	def advising_ajax
		@user = @current_user
		@course = Course.find(params[:id])

		# if course has been taken then show an error
		@user_course = UsersCourse.where(user_id: @user.id, course_id: @course.id).first
		if @user_course
			error_messages = Array.new
			error_messages << "You have taken #{@course.name} before"
			respond_to do |format|
				format.html
				format.json { render json: { :error => true, :error_messages => error_messages } }
				format.js
			end
			return
		end

		# check whether user has taken all the prerequisites for the course
		check_prerequisitesArray = check_prerequisites(@user, @course)
		# if there is no prerequisite error then save the course
		if(check_prerequisitesArray.count == 0)
			@user_course = UsersCourse.new(user_id: @user.id, course_id: @course.id, taken_planned: params[:date])
			@user_course.save
			@json_response = get_user_courses_completion_json(@user)
			respond_to do |format|
		    	format.html
		    	format.json { render json: @json_response }
		    	format.js
		    end
		# if there is a prerequisite error send json error and the error messages back
		else
			respond_to do |format|
				format.html
				format.json { render json: { :error => true, :error_messages => check_prerequisitesArray } }
				format.js
			end
		end
	end

	# handles ajax for course transfers between semesters
	def advising_ajax_move
		@user = @current_user
		@course = Course.find(params[:id])

		# check prerequisites error upon the move
		error_messages = check_prerequisites_on_change(@user, @course, 'move')

		# if there is no prerequisite error then update the course to be taken at the new date
		if error_messages.length == 0
			@user_course =  UsersCourse.where(user_id: @user.id, course_id: @course.id).first
			@user_course.update_attributes(:taken_planned => params[:date])
			@json_response = get_user_courses_completion_json(@user)
			respond_to do |format|
		    	format.html
		    	format.json { render json: @json_response }
		    	format.js
		    end
		# if there is a prerequisite error then send json error and the error messages back
		else
			respond_to do |format|
				format.html
				format.json { render json: { :error => true, :error_messages => error_messages } }
				format.js
			end
		end
	end

	# handles ajax for course deletion
	def advising_ajax_delete
		@user = @current_user
		@course = Course.find(params[:id])

		# check prerequisites error upon the remove
		error_messages = check_prerequisites_on_change(@user, @course, 'remove')

		# if there is no prerequisite error then delete the course
		if error_messages.length == 0
			@user.course.delete(@course)
			@json_response = get_user_courses_completion_json(@user)
			respond_to do |format|
				format.json { render json: @json_response }
			end
		# if there is a prerequisite error then send json error and the error messages back
		else
			respond_to do |format|
				format.json { render json: { :error => true, :error_messages => error_messages } }
			end
		end
	end

	# pack hashes from get_semesters_courses and check_completion functions to json
	def get_user_courses_completion_json(user)
		@user_courses_hash = get_semesters_courses
		@completion_hash = check_completion(user)

		@json_response = Hash.new
		@json_response["user_courses"] = @user_courses_hash
		@json_response["completion"] = @completion_hash

		return @json_response.to_json
	end

	# check which major, minor, distribution, and concentration that the user has completed
	def check_completion(user)
		completion_hash = Hash.new

		# check the user's major(s), make sure the user has taken all the required courses
		completion_hash["major"] = Hash.new
		user.major.each do |major|
			completion_hash["major"][major.id] = true
			major.course.each do |major_course|
				user_course = UsersCourse.where(user_id: user.id, course_id: major_course.id).first
				if(!user_course)
					completion_hash["major"][major.id] = false
					break
				end
			end
		end

		# check the user's minor(s), make sure the user has taken all the required courses
		# or have completed the minimum hours required for the minor
		completion_hash["minor"] = Hash.new
		user.minor.each do |minor|
			completion_hash["minor"][minor.id] = true
			course_hours = 0
			minor.course.each do |minor_course|
				user_course = UsersCourse.where(user_id: user.id, course_id: minor_course.id).first
				if(!user_course)
					completion_hash["minor"][minor.id] = false
					break
				else
					course_hours += minor_course.hr_low
				end
			end
			# if student has fulfilled the required hours for the minor then he/she has completed the minor
			if(course_hours >= minor.total_hours)
				completion_hash["minor"][minor.id] = true
			end
		end

		# check the user's concentration(s), make sure the user has taken all the required courses
		completion_hash["concentration"] = Hash.new
		user.concentration.each do |concentration|
			completion_hash["concentration"][concentration.id] = true
			concentration.course.each do |concentration_course|
				user_course = UsersCourse.where(user_id: user.id, course_id: concentration_course.id).first
				if(!user_course)
					completion_hash["concentration"][concentration.id] = false
					break
				end
			end
		end

		# check whether the user has finished all the distributions
		completion_hash["distribution"] = Hash.new
		Distribution.find_each do |distribution|

			# must complete every courses for CORE
			if(distribution.title == "CORE")
				completion_hash["distribution"][distribution.id] = true
				distribution.course.each do |distribution_course|
					user_course = UsersCourse.where(user_id: user.id, course_id: distribution_course.id).first
					if(!user_course)
						completion_hash["distribution"][distribution.id] = false
						break
					end
				end
			else
				# must complete at least one course for other distributions
				distribution.course.each do |distribution_course|
					completion_hash["distribution"][distribution.id] = false
					user_course = UsersCourse.where(user_id: user.id, course_id: distribution_course.id).first
					if(user_course)
						completion_hash["distribution"][distribution.id] = true
						break
					end
				end
			end
		end

		# returns a hash
		return completion_hash
	end

	# checks whether all prerequisites of a course has been taken
	def check_prerequisites(user, course)
		errors = Array.new
		course.prerequisite.each do |prereq|
			prerequisite = UsersCourse.where(user_id: user.id, course_id: prereq.id).first
			if(prerequisite)
				prerequisite_taken_on = @semesters.index(prerequisite.taken_planned)
				course_taken_on = @semesters.index(params[:date])
				if(prerequisite_taken_on >= course_taken_on)
					errors << "Prerequisite error for #{course.subject} #{course.course_number}: #{prereq.subject} #{prereq.course_number} must be taken earlier"
				end
			else
				errors << "Prerequisite error for #{course.subject} #{course.course_number}: #{prereq.subject} #{prereq.course_number} not taken yet"
			end
		end
		return errors
	end

	# checks whether the change would cause prerequisite conflict
	def check_prerequisites_on_change(user, course, string)
		error_messages = Array.new

		if string == "move"
			error_messages = check_prerequisites(user, course)
			if error_messages.length != 0
				return error_messages
			end
		end

		if course
			user.course.each do |user_course|
				if user_course.id != course.id
					user_course.prerequisite.each do |prereq|
						if prereq.id == course.id
							error_messages << "Cannot #{string} course: #{course.subject} #{course.course_number} is a prerequisite for #{user_course.subject} #{user_course.course_number}"
							break
						end
					end
				end
			end
		end

		# returns error messages if any
		return error_messages
	end

	# get each semester's courses
	def get_semesters_courses
		@user_courses = UsersCourse.where(user_id: @user.id)
		@user_courses_hash = Hash.new
		@semesters.each do |semester|
			@user_courses_hash["#{semester}"] = Array.new
		end
		@user_courses.each do |course|
			if(@user_courses_hash.has_key?(course.taken_planned))
				@user_courses_hash["#{course.taken_planned}"] << Course.find(course.course_id)
			end
		end
		return @user_courses_hash
	end

	# get each semester's hours
	def get_semesters_hours
		@user_courses_hash = get_semesters_courses
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