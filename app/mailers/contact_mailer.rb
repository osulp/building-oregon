class ContactMailer < ActionMailer::Base
  
  def contact_email(email, message)
    @email = email
    @message = message
    mail(:to => "brandon.straley@oregonstate.edu", :subject => "General Inquiry", :from => @email)
  end
end
