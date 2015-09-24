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

	def major_params
		params.require(:major).permit(:name, :total_hours)
	end

end
