class MajorsCoursesController < ApplicationController

	def index
		@majors = Major.all
	end

	def new
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
		MajorsCourse.find(params[:id]).destroy
      	redirect_to '/majors_courses'
	end

	def majors_course_params
		params.require(:majors_course).permit(:major_id, :course_id)
	end

end
