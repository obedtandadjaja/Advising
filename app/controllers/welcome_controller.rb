class WelcomeController < ApplicationController

	before_filter :authorize, :set_courses, :set_hours
	respond_to :js, :json, :html

	def set_courses
		@courses = []
	end

	def set_hours
		@hours = 0
	end

	def index
		@user = User.find(session[:user_id])
		@distributions = Distribution.order(:title)
		@majors = @user.major
		@minors = @user.minor
		@courses = @user.course
		puts @hours
	end

	def advising_ajax
		@user = User.find(session[:user_id])
		@course = Course.find(params[:id])
		@courses << @course
		@hours = @hours + @course.credit

		respond_to do |format|
	      format.html { redirect_to :back }
	      format.json { head :no_content }
	      format.js {
	        render 'welcome/update_hours'
	      }
	    end
	end
	
end
