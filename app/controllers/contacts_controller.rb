class ContactsController < ApplicationController

  def index
    @contact = ContactEmail.new
  end
  
  def create
    @contact = ContactEmail.new(contact_params)
    unless @contact.valid? && verify_recaptcha(:model => @contact)
      flash[:error] = t('mail_error')
      render :index
    else
      if @contact.deliver
        flash[:success] = t('mail_success')
      end
      redirect_to root_path
    end
  end

  private

  def contact_params
    params.require(:contact_email).permit(:email, :message).to_h.symbolize_keys
  end 
end
