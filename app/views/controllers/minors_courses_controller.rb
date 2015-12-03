class MinorsCoursesController < ApplicationController

	def index
		@minors = Minor.all
	end

	def new
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
