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

class CoursePrerequisitesController < ApplicationController

	# displays all courses and its prerequisites
	def index
		@courses = Course.all
	end

	# display the form for creating new course-prerequisite relation
	def new
	end

	# display a particular course and its prerequisites
	def show
		@course = Course.find(params[:id])
	end

	# handles the post method from new course-prerequisite form
	def create
		course_prerequisite = CoursePrerequisite.new(courses_course_params)
		if course_prerequisite.save
			redirect_to '/course_prerequisites'
		else
			flash[:danger] = "The form you submitted is invalid."
			redirect_to '/course_prerequisites/new'
		end
	end

	# handles delete method from course
	def destroy
		CoursePrerequisite.where(course_id: params[:course_id], prerequisite_id: params[:prerequisite_id]).first.destroy
		flash[:success] = "Successfully removed!"
      	redirect_to '/course_prerequisites'
	end

	private
	# strong params
	def courses_course_params
		params.require(:course_prerequisite).permit(:course_id, :prerequisite_id)
	end

end
