class ConcentrationsController < ApplicationController

	def index
		@concentrations = Concentration.all
	end

	def new
	end

	def create
		concentration = Concentration.new(concentration_params)
		if concentration.save
			redirect_to '/concentrations'
		else
			flash[:notice] = "The form you submitted is invalid."
			redirect_to '/concentrations/new'
		end
	end

	def destroy
		Concentration.find(params[:id]).destroy
      	redirect_to '/concentrations'
	end

	def show
		@concentration = Concentration.find(params[:id])
	end

	def edit
		@concentration = Concentration.find(params[:id])
		@major_id = @concentration.major_id
	end

	def update
		@concentration = Concentration.find(params[:id])

	    if @concentration.update_attributes(concentration_params)

	      redirect_to :action => 'show', :id => @concentration

	    end
	end

	private
	def concentration_params
		params.require(:concentration).permit(:name, :total_hours, :major_id)
	end

end
