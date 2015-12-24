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

	def index
		@users = User.order(:name)
	end

	def show
		@user = User.find(params[:id])

		@total_hours = 0
		@user.course.each do |course|
			@total_hours += course.hr_low
		end
	end

	def new
	end

	def create
		users_course = UsersCourse.new(users_course_params)
		if users_course.save
			redirect_to '/users_courses'
		else
			flash[:danger] = "The form you submitted is invalid."
			redirect_to '/users_courses/new'
		end
	end

	def destroy
		@user = User.find(params[:user_id])
		@user_course = @user.course.find(params[:id])
		
		if @user_course
			@user.course.delete(@user_course)
		end
		flash[:success] = "Successfully deleted"
      	redirect_to '/users_courses/'+params[:user_id]
	end

	def users_course_params
		params.require(:users_course).permit(:user_id, :course_id, :taken_on)
	end

end
