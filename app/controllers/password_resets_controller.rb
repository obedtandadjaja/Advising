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

class PasswordResetsController < ApplicationController

	# display form for password reset request
    def new
    end

    # handles post from password reset request form
    def create
	    user = User.find_by_email(params[:email])
	    user.send_password_reset if user
	    flash[:success] = "Email sent with password reset instructions."
	    redirect_to '/login'
	end

	# displays form for password reset
	def edit
	    @user = User.find_by_password_reset_token!(params[:id])
	end

	# handles password update
	def update
	    @user = User.find_by_password_reset_token!(params[:id])
	    if @user.password_reset_sent_at < 1.hours.ago
	  	    flash[:danger] = "Password reset has expired."
	    	redirect_to new_password_reset_path
	    elsif @user.update_attributes(params.require(:user).permit(:password, :password_confirmation))
	  		flash[:success] = "Password has been reset!"
	    	redirect_to '/login'
	    else
	  		flash[:danger] = Array.new
	    	@user.errors.full_messages.each do |error_message|
	        	flash[:danger] << error_message
	    	end
	    	render :edit
	  	end
	end

end
