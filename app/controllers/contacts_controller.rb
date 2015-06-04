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
      flash[:success] = "Thank you for contacting us!" if ContactMailer.contact_email(@email, @message).deliver_now
      redirect_to root_path
    end
  end

  private
  def contact_params
    params["Contact"]
  end 
end
