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
