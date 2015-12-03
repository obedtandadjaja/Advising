class UsersConcentrationsController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def new
	end

	def create
		users_concentration = UsersConcentration.new(users_concentration_params)
		if users_concentration.save
			redirect_to '/users_concentrations'
		else
			flash[:notice] = "The form you submitted is invalid."
			redirect_to '/users_concentrations/new'
		end
	end

	def destroy
		@user = User.find(params[:user_id])
		@user_concentration = @user.concentration.find(params[:id])
		
		if @user_concentration
			@user.concentration.delete(@user_concentration)
		end

      	redirect_to '/users_concentrations/'+params[:user_id]
	end

	def users_concentration_params
		params.require(:users_concentration).permit(:user_id, :concentration_id)
	end
	
end
