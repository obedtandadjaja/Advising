class CoursesController < ApplicationController

	def index
		@courses = Course.all
	end

	def new
	end

	def show
		@course = Course.find(params[:id])
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

	def edit
		@course = Course.find(params[:id])
		@majors = @course.major
		@distributions = @course.distribution
		@minors = @course.minor
		@concentrations = @course.concentration
	end

	def update
		@course = Course.find(params[:id])

	    if @course.update_attributes(course_params_update)

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

	      redirect_to :action => 'show', :id => @course

	    end
	end

	def destroy
		Course.find(params[:id]).destroy
      	redirect_to '/courses'
	end

	def course_params
		params.require(:course).permit(:title, :subject, :number, :credit, :dateOffered, :crn)
	end

	def course_params_update
		params.require(:course).permit(:title, :subject, :number, :credit, :crn, :major_id, :minor_id, :concentration_id, :distribution_id)
	end

end
