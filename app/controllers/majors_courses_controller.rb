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

class MajorsCoursesController < ApplicationController

	def index
		@majors = Major.all
	end

	def new
	end

	def show
		@major = Major.find(params[:id])
		@major_courses = MajorsCourse.where(major_id: params[:id])
	end

	def create
		majors_course = MajorsCourse.new(majors_course_params)
		if majors_course.save
			redirect_to '/majors_courses'
		else
			flash[:notice] = "The form you submitted is invalid."
			redirect_to '/majors_courses/new'
		end
	end

	def destroy
		MajorsCourse.where(course_id: params[:id]).first.destroy
      	redirect_to '/majors_courses'
	end

	def majors_course_params
		params.require(:majors_course).permit(:major_id, :course_id)
	end

end
