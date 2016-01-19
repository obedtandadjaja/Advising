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

    # check a session exists or not
    def new
        if cookies.signed[:auth_token]
            redirect_to '/advising'
        end
    end

    # handles post from login form
    def create
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            if params[:remember_me]
                cookies.signed[:auth_token] = { value: user.auth_token, expires: 12.weeks.from_now }
            else
                cookies.signed[:auth_token] = user.auth_token
            end
            redirect_to '/advising'
        else
            flash[:danger] = "The email/password you entered is incorrect. Please try again."
            redirect_to '/login'
        end
    end

    # Log out
    def destroy
        cookies.delete(:auth_token)
        redirect_to '/login'
    end

end
