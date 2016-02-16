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

class MinorsController < ApplicationController
	before_filter :authorize, :only_admin
	
	# displays all minors
	def index
		@minors = Minor.order(:name)
	end

	# displays form for creating new minor
	def new
	end

	# handles post method from new minor form
	def create
		minor = Minor.new(minor_params)
		if minor.save
			redirect_to '/minors'
		else
			flash[:notice] = "The form you submitted is invalid."
			redirect_to '/minors/new'
		end
	end

	# handles deletes
	def destroy
		Minor.find(params[:id]).destroy
      	redirect_to '/minors'
	end

	# displays a particular minor
	def show
		@minor = Major.find(params[:id])
	end

	# displays minor update form
	def edit
		@minor = Minor.find(params[:id])
	end

	# handles updates
	def update
		@minor = Minor.find(params[:id])

	    if @minor.update_attributes(minor_params)

	      redirect_to :action => 'show', :id => @minor

	    end
	end

	private
	# strong params
	def minor_params
		params.require(:minor).permit(:name, :department, :total_hours)
	end

end
