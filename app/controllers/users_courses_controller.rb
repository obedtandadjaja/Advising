class UsersCoursesController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])

		@total_hours = 0
		@user.course.each do |course|
			@total_hours += course.credit
		end
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
		@user = User.find(params[:user_id])
		@user_course = @user.course.find(params[:id])
		
		if @user_course
			@user.course.delete(@user_course)
		end

      	redirect_to '/users_courses/'+params[:user_id]
	end

	def users_course_params
		params.require(:users_course).permit(:user_id, :course_id, :taken_on)
	end

end
