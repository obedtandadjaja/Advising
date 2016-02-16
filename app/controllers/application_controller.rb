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

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # check if the auth token in the browser cookie matches any the authentication token in the users table
  def current_user
    @current_user ||= User.find_by_auth_token!(cookies.signed[:auth_token]) if cookies.signed[:auth_token]
  end
  # calls the method
  helper_method :current_user

  # if not logged in then go to login page
  def authorize
    redirect_to '/login' unless current_user
  end

  # pages only for admins
  def only_admin
    redirect_to '/' unless (is_admin || is_teacher)
  end

  # return true if user is admin
  def is_admin
    "admin".include? current_user.role
  end

  def is_teacher
    "teacher".include? current_user.role
  end

end
