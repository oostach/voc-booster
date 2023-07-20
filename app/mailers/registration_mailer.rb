# frozen_string_literal: true

class RegistrationMailer < ApplicationMailer
  def confirmation_email
    @user = params[:user]
    mail(to: @user.email, subject: t('.confirmation_subject'))
  end
end
