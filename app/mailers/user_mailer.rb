class UserMailer < ApplicationMailer

  	def password_reset(user)
    	@user = user
    	mail :to => user.email, :subject => "Covenant College Advising Password Reset", :from => "admin@covenantadvising.edu"
  	end

  	def invite(user)
    	@user = user
    	mail :to => user.email, :subject => "Covenant College Advising Invite", :from => "admin@covenantadvising.edu"
  	end

end
