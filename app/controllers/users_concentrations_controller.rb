#
#   Copyright 2015 Amy Dewaal and Obed Tandadjaja
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

class UsersConcentrationsController < ApplicationController
	before_filter :authorize, :only_admin
	
	# displays all users and their concentrations
	def index
		if @current_user.is_admin?
			@users = User.where(role: "teacher")
			@users += User.where(role: "student")
		elsif @current_user.is_teacher?
			@users = User.where(role: "student")
		end
	end

	# displays a particular user and his/her concentration(s)
	def show
		@user = User.find(params[:id])
	end

	# display the form for creating new user-concentration relation
	def new
	end

	# handles creates
	def create
		users_concentration = UsersConcentration.new(users_concentration_params)
		if users_concentration.save
			redirect_to '/users_concentrations'
		else
			flash[:danger] = "The form you submitted is invalid."
			redirect_to '/users_concentrations/new'
		end
	end

	# handles deletes
	def destroy
		@user = User.find(params[:user_id])
		@user_concentration = @user.concentration.find(params[:id])
		
		if @user_concentration
			@user.concentration.delete(@user_concentration)
		end
		flash[:success] = "Successfully deleted"
      	redirect_to '/users_concentrations/'+params[:user_id]
	end

	private
	# strong params
	def users_concentration_params
		params.require(:users_concentration).permit(:user_id, :concentration_id)
	end
	
end
