class UsersCoursesController < ApplicationController

	def index
		@users = User.courses
	end

	def show
	end

	def new
	end

	def create
		users_course = UsersCourse.new(users_course_params)
		if users_course.save
			redirect_to '/users_courses'
		else
			flash[:notice] = "The form you submitted is invalid."
			redirect_to '/users_courses/new'
		end
	end

	def destroy
		UsersCourse.find(params[:id]).destroy
      	redirect_to '/users_courses/[:id]'
	end

	def users_course_params
		params.require(:users_course).permit(:user_id, :course_id, :taken_on)
	end

end
