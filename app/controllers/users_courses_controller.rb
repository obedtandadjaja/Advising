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

class UsersCoursesController < ApplicationController
	before_filter :authorize, :only_admin
	
	# displays all users and its corresponding courses
	def index
		@users = User.order(:name)
	end

	# displays a particular user and its courses
	def show
		@user = User.find(params[:id])

		@total_hours = 0
		@user.course.each do |course|
			@total_hours += course.hr_low
		end
	end

	# displays form for creating new user-course relation
	def new
	end

	# handles post method from new
	def create
		users_course = UsersCourse.new(users_course_params)
		if users_course.save
			redirect_to '/users_courses'
		else
			flash[:danger] = "The form you submitted is invalid."
			redirect_to '/users_courses/new'
		end
	end

	# handles deletes
	def destroy
		@user = User.find(params[:user_id])
		@user_course = @user.course.find(params[:id])

		error_messages = Array.new
		if @user_course
			@user.course.each do |course|
				if course.id != @user_course.id
					course.prerequisite.each do |prereq|
						if prereq.id == @user_course.id
							error_messages << "Cannot remove course: #{@user_course.subject} #{@user_course.course_number} is a prerequisite for #{course.subject} #{course.course_number}"
							break
						end
					end
				end
			end
		end

		if error_messages.length == 0
			@user.course.delete(@user_course)
			redirect_to :back
		else
			flash[:danger] = error_messages.first
			redirect_to :back
		end
	end

	private
	# strong params
	def users_course_params
		params.require(:users_course).permit(:user_id, :course_id, :taken_on)
	end

end
