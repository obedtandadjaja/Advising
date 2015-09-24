class ConcentrationsController < ApplicationController

	def index
		# @majors = Major.joins("LEFT OUTER JOIN concentrations ON concentrations.major_id = majors.id")
		@majors = Major.joins(:concentration).group("majors.id")
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

	def concentration_params
		params.require(:concentration).permit(:name, :total_hours, :major_id)
	end

end
