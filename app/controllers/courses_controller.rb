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

class CoursesController < ApplicationController
	before_filter :authorize, :is_admin
	
	# display all courses
	def index
		@courses = Course.all
	end

	# display form for creating new course
	def new
	end

	# display a particular course
	def show
		@course = Course.find(params[:id])
	end

	# handles post from new course form
	def create
		course = Course.new(course_params)
		if course.save

		  params[:course]["major_id"].each do |major_id|
	        if !major_id.empty?
	          course.major << Major.find(major_id)
	        end
	      end

	      params[:course]["minor_id"].each do |minor_id|
	        if !minor_id.empty?
	          course.minor << Minor.find(minor_id)
	        end
	      end

	      params[:course]["concentration_id"].each do |concentration_id|
	        if !concentration_id.empty?
	          course.concentration << Concentration.find(concentration_id)
	        end
	      end

	      params[:course]["distribution_id"].each do |distribution_id|
	        if !distribution_id.empty?
	          course.distribution << Distribution.find(distribution_id)
	        end
	      end

			redirect_to '/courses'
		else
			flash[:danger] = "The form you submitted is invalid."
			redirect_to '/courses/new'
		end
	end

	# displays form for updating a course
	def edit
		@course = Course.find(params[:id])
		@majors = @course.major
		@distributions = @course.distribution
		@minors = @course.minor
		@concentrations = @course.concentration
	end

	# handles put|patch from edit form
	def update
		@course = Course.find(params[:id])

	    if @course.update_attributes(course_params)

	      @course.major.clear
	      @course.minor.clear
	      @course.concentration.clear
	      @course.distribution.clear

	      params[:course]["major_id"].each do |major_id|
	        if !major_id.empty?
	          @course.major << Major.find(major_id)
	        end
	      end

	      params[:course]["minor_id"].each do |minor_id|
	        if !minor_id.empty?
	          @course.minor << Minor.find(minor_id)
	        end
	      end

	      params[:course]["concentration_id"].each do |concentration_id|
	        if !concentration_id.empty?
	          @course.concentration << Concentration.find(concentration_id)
	        end
	      end

	      params[:course]["distribution_id"].each do |distribution_id|
	        if !distribution_id.empty?
	          @course.distribution << Distribution.find(distribution_id)
	        end
	      end

	      flash[:success] = "Successfully updated"
	      redirect_to :action => 'show', :id => @course

	    end
	end

	# handles delete
	def destroy
		Course.find(params[:id]).destroy
		flash[:success] = "Successfully deleted"
      	redirect_to '/courses'
	end

	private
	# strong params
	def course_params
		params.require(:course).permit(:title, :subject, :course_number, :hr_low, :hr_high, :major_id, :minor_id, :concentration_id, :distribution_id)
	end

end
