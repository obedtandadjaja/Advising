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

	def index
		@minors = Minor.order(:name)
	end

	def new
	end

	def create
		minor = Minor.new(minor_params)
		if minor.save
			redirect_to '/minors'
		else
			flash[:notice] = "The form you submitted is invalid."
			redirect_to '/minors/new'
		end
	end

	def destroy
		Minor.find(params[:id]).destroy
      	redirect_to '/minors'
	end

	def show
		@minor = Major.find(params[:id])
	end

	def edit
		@minor = Minor.find(params[:id])
	end

	def update
		@minor = Minor.find(params[:id])

	    if @minor.update_attributes(minor_params)

	      redirect_to :action => 'show', :id => @minor

	    end
	end

	private
	def minor_params
		params.require(:minor).permit(:name, :department, :total_hours)
	end

end
