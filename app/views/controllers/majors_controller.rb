class MajorsController < ApplicationController

	def index
		@majors = Major.all
	end

	def new
	end

	def create
		major = Major.new(major_params)
		if major.save
			redirect_to '/majors'
		else
			flash[:notice] = "The form you submitted is invalid."
			redirect_to '/majors/new'
		end
	end

	def destroy
		Major.find(params[:id]).destroy
      	redirect_to '/majors'
	end

	def show
		@major = Major.find(params[:id])
	end

	def edit
		@major = Major.find(params[:id])
	end

	def update
		@major = Major.find(params[:id])

	    if @major.update_attributes(major_params)

	      redirect_to :action => 'show', :id => @major

	    end
	end

	private
	def major_params
		params.require(:major).permit(:name, :total_hours)
	end

end
