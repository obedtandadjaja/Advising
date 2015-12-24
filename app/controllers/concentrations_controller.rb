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

class ConcentrationsController < ApplicationController

	def index
		@concentrations = Concentration.order(:name)
	end

	def new
	end

	def create
		concentration = Concentration.new(concentration_params)
		if concentration.save
			redirect_to '/concentrations'
		else
			flash[:danger] = "The form you submitted is invalid."
			redirect_to '/concentrations/new'
		end
	end

	def destroy
		Concentration.find(params[:id]).destroy
		flash[:success] = "Successfully deleted"
      	redirect_to '/concentrations'
	end

	def show
		@concentration = Concentration.find(params[:id])
	end

	def edit
		@concentration = Concentration.find(params[:id])
		@major_id = @concentration.major_id
	end

	def update
		@concentration = Concentration.find(params[:id])
	    if @concentration.update_attributes(concentration_params)
	    	flash[:success] = "Successfully updated"
	    	redirect_to :action => 'show', :id => @concentration
	    end
	end

	private
	def concentration_params
		params.require(:concentration).permit(:name, :total_hours, :major_id)
	end

end
