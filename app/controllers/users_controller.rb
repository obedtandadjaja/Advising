class UsersController < ApplicationController

  def new
  end

  def show
    @user = User.find(params[:id])
  end

  def create

    @user = User.new(user_params)

    if @user.save

      # draw links to the user
      params[:user]["major_id"].each do |major_id|
        if !major_id.empty?
          @user.major << Major.find(major_id)
        end
      end

      params[:user]["minor_id"].each do |minor_id|
        if !minor_id.empty?
          @user.minor << Minor.find(minor_id)
        end
      end

      params[:user]["concentration_id"].each do |concentration_id|
        if !concentration_id.empty?
          @user.concentration << Concentration.find(concentration_id)
        end
      end

      redirect_to '/login'
    else
      flash[:notice] = "The form you submitted is invalid."
      redirect_to '/signup'
    end
  end

  def edit
    @user = User.find(params[:id])
    @majors = @user.major
    @minors = @user.minor
    @concentrations = @user.concentration
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params_update)

      @user.major.clear
      @user.minor.clear
      @user.concentration.clear

      params[:user]["major_id"].each do |major_id|
        if !major_id.empty?
          @user.major << Major.find(major_id)
        end
      end

      params[:user]["minor_id"].each do |minor_id|
        if !minor_id.empty?
          @user.minor << Minor.find(minor_id)
        end
      end

      params[:user]["concentration_id"].each do |concentration_id|
        if !concentration_id.empty?
          @user.concentration << Concentration.find(concentration_id)
        end
      end

      redirect_to :action => 'show', :id => @user

    end
  end

  def destroy
      User.find(params[:id]).destroy
      redirect_to '/users'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  private
  def user_params_update
    params.require(:user).permit(:name, :email)
  end

end
