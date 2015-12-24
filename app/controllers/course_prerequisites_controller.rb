class CoursePrerequisitesController < ApplicationController

	def index
		@courses = Course.all
	end

	def new
	end

	def show
		@course = Course.find(params[:id])
	end

	def create
		course_prerequisite = CoursePrerequisite.new(courses_course_params)
		if course_prerequisite.save
			redirect_to '/course_prerequisites'
		else
			flash[:danger] = "The form you submitted is invalid."
			redirect_to '/course_prerequisites/new'
		end
	end

	def destroy
		CoursePrerequisite.where(course_id: params[:course_id], prerequisite_id: params[:prerequisite_id]).first.destroy
		flash[:success] = "Successfully removed!"
      	redirect_to '/course_prerequisites'
	end

	def courses_course_params
		params.require(:course_prerequisite).permit(:course_id, :prerequisite_id)
	end

end
