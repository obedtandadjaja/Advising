class UserMailer < ApplicationMailer

  	def invite(user)
    	@user = user
    	mail :to => user.email, :subject => "Covenant College Advising Invite", :from => "admin@covenantadvising.edu"
  	end

end
