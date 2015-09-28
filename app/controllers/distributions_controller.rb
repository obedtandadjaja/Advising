class DistributionsController < ApplicationController

	def index
		@distributions = Distribution.all
	end

	def new
	end

	def create
		distribution = Distribution.new(distribution_params)
		if distribution.save
			redirect_to '/distributions'
		else
			flash[:notice] = "The form you submitted is invalid."
			redirect_to '/distributions/new'
		end
	end

	def destroy
		Distribution.find(params[:id]).destroy
      	redirect_to '/distributions'
	end

	def distribution_params
		params.require(:distribution).permit(:title)
	end

	def show
		@distribution = Distribution.find(params[:id])
	end

	def edit
		@distribution = Distribution.find(params[:id])
	end

	def update
		@distribution = Distribution.find(params[:id])

	    if @distribution.update_attributes(distribution_params)

	      redirect_to :action => 'show', :id => @distribution

	    end
	end

end
