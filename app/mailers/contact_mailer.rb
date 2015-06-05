class ContactMailer < ActionMailer::Base
  
  def contact_email(email, message)
    @email = email
    @message = message
    if Setting.contact.blank?
      mail(:to => "margaret.mellinger@oregonstate.edu" , :subject => "General Inquiry", :from => @email)
    else
      mail(:to => Setting.contact, :subject => "General Inquiry", :from => @email)
    end
  end
end
