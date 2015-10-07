class WelcomeController < ApplicationController

	before_filter :authorize

	def index
		@user = User.find(session[:user_id])
		@distributions = Distribution.order(:title)
	end

	def advising_ajax
		
	end
	
end
