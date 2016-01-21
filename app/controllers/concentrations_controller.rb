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
	before_filter :authorize, :is_admin

	# displays all of the concentrations
	def index
		@concentrations = Concentration.order(:name)
	end

	# displays the form to make a new concentration
	def new
	end

	# handles the post method from the new concentration form
	def create
		# creates the new concentration with a pre-defined params
		concentration = Concentration.new(concentration_params)
		if concentration.save
			redirect_to '/concentrations'
		else
			flash[:danger] = "The form you submitted is invalid."
			redirect_to '/concentrations/new'
		end
	end

	# handles delete form method
	def destroy
		Concentration.find(params[:id]).destroy
		flash[:success] = "Successfully deleted"
      	redirect_to '/concentrations'
	end

	# displays the information for a particular concentration
	def show
		@concentration = Concentration.find(params[:id])
	end

	# displays the form for updating the concentration
	def edit
		@concentration = Concentration.find(params[:id])
		@major_id = @concentration.major_id
	end

	# handles patch|put form method from concentrations.edit
	def update
		@concentration = Concentration.find(params[:id])
	    if @concentration.update_attributes(concentration_params)
	    	flash[:success] = "Successfully updated"
	    	redirect_to :action => 'show', :id => @concentration
	    end
	end

	private
	# strong parameters to prevent user from submitting form data that we do not expect
	def concentration_params
		params.require(:concentration).permit(:name, :total_hours, :major_id)
	end

end
