class MinorsController < ApplicationController

	def index
		@minors = Minor.all
	end

	def new
	end

	def create
		minor = Minor.new(minor_params)
		if minor.save
			redirect_to '/minors'
		else
			flash[:notice] = "The form you submitted is invalid."
			redirect_to '/minors/new'
		end
	end

	def destroy
		Minor.find(params[:id]).destroy
      	redirect_to '/minors'
	end

	def show
		@minor = Minor.find(params[:id])
	end

	def edit
		@minor = Minor.find(params[:id])
	end

	def update
		@minor = Minor.find(params[:id])

	    if @minor.update_attributes(minor_params)

	      redirect_to :action => 'show', :id => @minor

	    end
	end

	private
	def minor_params
		params.require(:minor).permit(:name, :total_hours)
	end

end
