class ContactMailer < ActionMailer::Base
  def contact_email(email, message, to_email )
    @email = email
    @message = message
    @to_email = to_email
    mail(:to => @to_email, :subject => "Building Oregon General Inquiry", :from => @email)
  end
end
