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

      flash[:success] = "You have successfully registered!"
      redirect_to '/login'
    else
      flash[:danger] = "The form you submitted is invalid."
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
