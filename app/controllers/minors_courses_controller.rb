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

class MinorsCoursesController < ApplicationController
	before_filter :authorize, :only_admin
	
	# displays all minors and its corresponding courses
	def index
		@minors = Minor.all
	end

	# displays the form for creating new minor-course relation
	def new
	end

	# display a particular minor and its courses
	def show
		@minor = Minor.find(params[:id])
	end

	# handles post method from new minor-course form
	def create
		minors_course = MinorsCourse.new(minors_course_params)
		if minors_course.save
			redirect_to '/minors_courses'
		else
			flash[:danger] = "The form you submitted is invalid."
			redirect_to '/minors_courses/new'
		end
	end

	# handles deletes
	def destroy
		MinorsCourse.where(course_id: params[:id], minor_id: params[:minor_id]).first.destroy
		flash[:success] = "Successfully deleted"
      	redirect_to '/minors_courses'
	end

	private
	# strong params
	def minors_course_params
		params.require(:minors_course).permit(:minor_id, :course_id)
	end

end
