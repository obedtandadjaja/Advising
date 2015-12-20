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

	def index
		@minors = Minor.all
	end

	def new
	end

	def show
		@minor = Minor.find(params[:id])
		@minor_courses = MinorsCourse.where(minor_id: params[:id])
	end

	def create
		minors_course = MinorsCourse.new(minors_course_params)
		if minors_course.save
			redirect_to '/minors_courses'
		else
			flash[:notice] = "The form you submitted is invalid."
			redirect_to '/minors_courses/new'
		end
	end

	def destroy
		MinorsCourse.find(params[:id]).destroy
      	redirect_to '/minors_courses'
	end

	def minors_course_params
		params.require(:minors_course).permit(:minor_id, :course_id)
	end

end
