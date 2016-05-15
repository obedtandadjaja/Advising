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

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :banner_id
    devise_parameter_sanitizer.for(:sign_up) << :enrollment_time
    devise_parameter_sanitizer.for(:sign_up) << :graduation_time
    devise_parameter_sanitizer.for(:sign_up) << :major
    devise_parameter_sanitizer.for(:sign_up) << :minor
    devise_parameter_sanitizer.for(:sign_up) << :concentration
    devise_parameter_sanitizer.for(:sign_in) << :email
    devise_parameter_sanitizer.for(:sign_in) << :password
  end

  # if not logged in then go to login page
  def authorize
    redirect_to '/users/sign_in' unless current_user
  end

  # pages only for admins
  def only_admin
    redirect_to '/advising' unless !is_student
  end

  # return true if user is admin
  def is_admin
    "admin".include? current_user.role
  end

  # return true if user is teacher
  def is_teacher
    "teacher".include? current_user.role
  end

  # return true if user is student
  def is_student
    !(is_teacher||is_admin)
  end

  def authenticate_current_user
    render json: {}, status: :unauthorized if current_user.nil?
  end

  def get_current_user
    return nil unless cookies[:auth_headers]
    auth_headers = JSON.parse cookies[:auth_headers]

    expiration_datetime = DateTime.strptime(auth_headers["expiry"], "%s")
    current_user = User.find_by uid: auth_headers["uid"]

    if current_user &&
       current_user.tokens.has_key?(auth_headers["client"]) &&
       expiration_datetime > DateTime.now

      @current_user = current_user
    end
    @current_user
  end

end
