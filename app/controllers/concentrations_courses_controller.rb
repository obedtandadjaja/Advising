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

# This controller handles the relationship between concentration model and course model
class ConcentrationsCoursesController < ApplicationController
	before_filter :authorize, :only_admin
	
	# displays all concentrations and its corresponding courses
	def index
		@concentrations = Concentration.all
	end

	# displays the form for creating new concentration-course relation
	def new
	end

	# displays a particular concentration and its corresponding courses
	def show
		@concentration = Concentration.find(params[:id])
	end

	# handles post from new concentration-course form
	def create
		concentrations_course = ConcentrationsCourse.new(concentrations_course_params)
		if concentrations_course.save
			redirect_to '/concentrations_courses'
		else
			flash[:danger] = "The form you submitted is invalid."
			redirect_to '/concentrations_courses/new'
		end
	end

	# handles delete form method
	def destroy
		ConcentrationsCourse.where(course_id: params[:id], concentration_id: params[:concentration_id]).first.destroy
		flash[:success] = "Successfully deleted"
      	redirect_to '/concentrations_courses'
	end

	private
	# strong params
	def concentrations_course_params
		params.require(:concentrations_course).permit(:concentration_id, :course_id)
	end

end
