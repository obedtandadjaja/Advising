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

class MajorsController < ApplicationController

	def index
		@majors = Major.order(:name)
	end

	def new
	end

	def create
		major = Major.new(major_params)
		if major.save
			redirect_to '/majors'
		else
			flash[:notice] = "The form you submitted is invalid."
			redirect_to '/majors/new'
		end
	end

	def destroy
		Major.find(params[:id]).destroy
      	redirect_to '/majors'
	end

	def show
		@major = Major.find(params[:id])
	end

	def edit
		@major = Major.find(params[:id])
	end

	def update
		@major = Major.find(params[:id])

	    if @major.update_attributes(major_params)

	      redirect_to :action => 'show', :id => @major

	    end
	end

	private
	def major_params
		params.require(:major).permit(:name, :total_hours)
	end

end
