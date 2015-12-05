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

class DistributionsController < ApplicationController

	def index
		@distributions = Distribution.all
	end

	def new
	end

	def create
		distribution = Distribution.new(distribution_params)
		if distribution.save 
			redirect_to '/distributions'
		else
			flash[:notice] = "The form you submitted is invalid."
			redirect_to '/distributions/new'
		end
	end

	def destroy
		Distribution.find(params[:id]).destroy
      	redirect_to '/distributions'
	end

	def distribution_params
		params.require(:distribution).permit(:title)
	end

	def show
		@distribution = Distribution.find(params[:id])
	end

	def edit
		@distribution = Distribution.find(params[:id])
	end

	def update
		@distribution = Distribution.find(params[:id])

	    if @distribution.update_attributes(distribution_params)

	      redirect_to :action => 'show', :id => @distribution

	    end
	end

end
