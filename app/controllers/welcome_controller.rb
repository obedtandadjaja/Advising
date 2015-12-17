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

class WelcomeController < ApplicationController

	before_filter :authorize, :set_courses, :set_hours
	respond_to :js, :json, :html

	def set_courses
		@courses = []
	end

	def set_hours
		@hours = 0
	end

	before_filter :authorize
	
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
