# frozen_string_literal: true

# Preview all emails at http://voc.dev/rails/mailers/registration_mailer
class RegistrationMailerPreview < ActionMailer::Preview
  def confirmation_email
    user = FactoryBot.create(:user)

    RegistrationMailer.with(user: user).confirmation_email
  end
end
