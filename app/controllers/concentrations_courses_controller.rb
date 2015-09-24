class ConcentrationsCoursesController < ApplicationController

	def index
		@concentrations_courses = ConcentrationsCourse.includes(:concentration, :course)
	end

	def new
	end

	def create
		concentrations_course = ConcentrationsCourse.new(concentrations_course_params)
		if concentrations_course.save
			redirect_to '/concentrations_courses'
		else
			flash[:notice] = "The form you submitted is invalid."
			redirect_to '/concentrations_courses/new'
		end
	end

	def destroy
		ConcentrationsCourse.find(params[:id]).destroy
      	redirect_to '/concentrations_courses'
	end

	def concentrations_course_params
		params.require(:concentrations_course).permit(:concentration_id, :course_id)
	end

end
