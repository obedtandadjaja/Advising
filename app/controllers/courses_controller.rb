class CoursesController < ApplicationController

	def index
		@courses = Course.all
	end

	def new
	end

	def create
		course = Course.new(course_params)
		if course.save
			redirect_to '/courses'
		else
			flash[:notice] = "The form you submitted is invalid."
			redirect_to '/courses/new'
		end
	end

	def destroy
		Course.find(params[:id]).destroy
      	redirect_to '/courses'
	end

	def course_params
		params.require(:course).permit(:title, :subject, :number, :credit, :dateOffered, :crn)
	end

end
