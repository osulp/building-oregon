class ContactEmail
  include ActiveModel::Model
  attr_reader :email, :message
  validates :email, :message, :presence => true
  def initialize(email: nil, message: nil)
    @email = email
    @message = message
  end

  def deliver
    mailer.deliver_now
  end

  private

  def mailer
    ContactMailer.contact_email(email, message, contact)
  end

  def contact
    if Setting.contact.blank?
      I18n.t('mailer.default_email')
    else
      Setting.contact
    end
  end
end
