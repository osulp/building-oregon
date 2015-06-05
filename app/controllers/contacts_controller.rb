class ContactsController < ApplicationController

  def index
  end
  
  def create
    @email ||= contact_params["email"]
    @message = contact_params["message"]
    if @email.blank?
      flash[:error] = "Please enter an email address and try again"
      render :index
    else
      flash[:success] = "Thank you for contacting us!" if mailer.deliver_now
      redirect_to root_path
    end
  end

  private

  def mailer
    if Setting.contact.blank?
      contact_mailer.contact_email(@email, @message, I18n.t('mailer.default_email')) 
    else
      contact_mailer.contact_email(@email, @message, Setting.contact) 
    end
  end

  def contact_mailer
    ContactMailer
  end

  def contact_params
    params["Contact"]
  end 
end
