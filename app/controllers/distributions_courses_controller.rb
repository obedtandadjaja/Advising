class DistributionsCoursesController < ApplicationController

	def index
		@distributions = Distribution.all
	end

	def new
	end

	def create
		distributions_course = DistributionsCourse.new(distributions_course_params)
		if distributions_course.save
			redirect_to '/distributions_courses'
		else
			flash[:notice] = "The form you submitted is invalid."
			redirect_to '/distributions_courses/new'
		end
	end

	def destroy
		DistributionsCourse.find(params[:id]).destroy
      	redirect_to '/distributions_courses'
	end

	def distributions_course_params
		params.require(:distributions_course).permit(:distribution_id, :course_id)
	end

end
