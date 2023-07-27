# frozen_string_literal: true

# Preview all emails at http://voc.dev/rails/mailers/registration_mailer
class RegistrationMailerPreview < ActionMailer::Preview
  def confirmation_email
    user = User.new(email: 'test@voc-booster.com', first_name: 'Jane', last_name: 'Doe', confirmation_token: SecureRandom.hex)

    RegistrationMailer.with(user: user).confirmation_email
  end
end
