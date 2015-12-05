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

class SessionsController < ApplicationController

  def new
    if session[:user_id]
      redirect_to '/welcome'
    end
  end

  def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around the website.
      session[:user_id] = user.id
      redirect_to '/welcome'
    else
      # If user's login doesn't work, send them back to the login form.
      flash[:notice] = "The email/password you entered is incorrect. Please try again."
      redirect_to '/login'
    end
  end

  # Log out
  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
