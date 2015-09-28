class UsersMajorsController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def new
	end

	def create
		users_major = UsersMajor.new(users_major_params)
		if users_major.save
			redirect_to '/users_majors'
		else
			flash[:notice] = "The form you submitted is invalid."
			redirect_to '/users_majors/new'
		end
	end

	def destroy
		@user = User.find(params[:user_id])
		@user_major = @user.major.find(params[:id])
		
		if @user_major
			@user.major.delete(@user_major)
		end

      	redirect_to '/users_majors/'+params[:user_id]
	end

	def users_major_params
		params.require(:users_major).permit(:user_id, :major_id)
	end

end
