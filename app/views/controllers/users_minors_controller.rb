class UsersMinorsController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def new
	end

	def create
		users_minor = UsersMinor.new(users_minor_params)
		if users_minor.save
			redirect_to '/users_minors'
		else
			flash[:notice] = "The form you submitted is invalid."
			redirect_to '/users_minors/new'
		end
	end

	def destroy
		@user = User.find(params[:user_id])
		@user_minor = @user.minor.find(params[:id])
		
		if @user_minor
			@user.minor.delete(@user_minor)
		end

      	redirect_to '/users_minors/'+params[:user_id]
	end

	def users_minor_params
		params.require(:users_minor).permit(:user_id, :minor_id)
	end

end
