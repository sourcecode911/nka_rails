class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: 'Ihr Zugang zur engineeringos Nebenkostenabrechnung')
  end

  def invoice_email(user, invoice_detail)
    @user = user
    @invoice_detail = invoice_detail
  end
end
