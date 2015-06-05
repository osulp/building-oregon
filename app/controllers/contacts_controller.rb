class ContactsController < ApplicationController

  def index
    @contact = ContactEmail.new
  end
  
  def create
    @contact = ContactEmail.new(contact_params)
    unless @contact.valid?
      flash[:error] = "Please enter an email address and try again"
      render :index
    else
      if @contact.deliver
        flash[:success] = "Thank you for contacting us!"
      end
      redirect_to root_path
    end
  end

  private

  def contact_params
    params.require(:contact_email).permit(:email, :message).to_h.symbolize_keys
  end 
end
