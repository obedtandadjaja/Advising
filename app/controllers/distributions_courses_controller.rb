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

class DistributionsCoursesController < ApplicationController
	before_filter :authorize, :only_admin
	
	# displas all distributions along with its courses
	def index
		@distributions = Distribution.all
	end

	# displays form for creating new distribution-course relation
	def new
	end

	# displays a particular distribution and its corresponding courses
	def show
		@distribution = Distribution.find(params[:id])
	end

	# handles post from distribution-course new form
	def create
		distributions_course = DistributionsCourse.new(distributions_course_params)
		if distributions_course.save
			redirect_to '/distributions_courses'
		else
			flash[:danger] = "The form you submitted is invalid."
			redirect_to '/distributions_courses/new'
		end
	end

	# handles delete
	def destroy
		DistributionsCourse.where(course_id: params[:id], distribution_id: params[:id]).first.destroy
		flash[:success] = "Successfully deleted"
      	redirect_to '/distributions_courses'
	end

	private
	# strong params
	def distributions_course_params
		params.require(:distributions_course).permit(:distribution_id, :course_id)
	end

end
