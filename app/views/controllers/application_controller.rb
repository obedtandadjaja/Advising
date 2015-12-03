class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    # finds the user_id that is stored in the browser cookie
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  # calls the method
  helper_method :current_user

  # if not logged in then go to login page
  def authorize
    redirect_to '/login' unless current_user
  end

end
