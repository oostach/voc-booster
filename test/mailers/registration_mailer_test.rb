# frozen_string_literal: true

require 'test_helper'

class RegistrationMailerTest < ActionMailer::TestCase
  test 'should send confirmation email after create' do
    assert_emails 1 do
      create(:user)
    end
  end

  test 'confirmation email' do
    user = create(:user)
    email = RegistrationMailer.with(user: user).confirmation_email

    assert_emails 1 do
      email.deliver_later
    end

    encoded_body = email.body.encoded
    assert_equal email.to, [user.email]
    assert_equal email.from, ['noreply@voc-booster.com']
    assert_equal email.subject, 'Welcome to VocBooster! Please Confirm Your Email Address.'
    assert_match 'Confirmation link', encoded_body
    assert_match "Dear #{user.first_name},", encoded_body
    assert_match confirmation_url(user.confirmation_token), encoded_body
    assert_match 'Thank you once again for choosing VocBooster. We look forward to seeing you on our platform soon.', encoded_body
  end
end
