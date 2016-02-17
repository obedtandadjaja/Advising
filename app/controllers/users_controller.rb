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
    before_filter :authorize, :except => [:new, :create]

    # display form for signing up
    def new
    end

    # displays a particular user
    def show
        @user = User.find(params[:id])
    end

    def become
        if(current_user.is_admin? || current_user.is_teacher?)
            render :nothing => true
        else
            sign_in(:user, User.find(params[:user][:id]))
            redirect_to root_url
        end
    end

    # handles user creation
    def create
        @user = User.new(user_params)
        if @user.save
            # draw links to the user
            params[:user]["major"].each do |major_id|
                if !major_id.empty?
                    @user.major << Major.find(major_id)
                end
            end

            params[:user]["minor"].each do |minor_id|
                if !minor_id.empty?
                    @user.minor << Minor.find(minor_id)
                end
            end

            params[:user]["concentration"].each do |concentration_id|
                if !concentration_id.empty?
                    @user.concentration << Concentration.find(concentration_id)
                end
            end

            flash[:success] = "You have successfully registered!"
            redirect_to '/login'
        else
            flash[:danger] = Array.new
            @user.errors.full_messages.each do |error_message|
                flash[:danger] << error_message
            end
            redirect_to '/signup'
        end
    end

    # displays edit form
    def edit
        @user = User.find(params[:id])
        @majors = @user.major
        @minors = @user.minor
        @concentrations = @user.concentration
    end

    # handles user information update
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

    # handles user deletion
    def destroy
        User.find(params[:id]).destroy
        redirect_to '/users'
    end

    private
    # strong params for sign up
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :banner_id,
       :enrollment_time, :graduation_time)
    end

    private
    # strong params for edit profile
    def user_params_update
      params.require(:user).permit(:name, :email, :banner_id, :enrollment_time, :graduation_time)
    end

end
