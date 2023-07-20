# frozen_string_literal: true

class User < ApplicationRecord
  CONFIRMATION_TOKEN_EXPIRATION = 60.minutes

  has_secure_password
  has_secure_password :confirmation_token, validations: false

  enum gender: { female: 1, male: 5, other: 10 }

  validates :first_name, :last_name, :password, presence: true
  validates :password_confirmation, presence: true, if: -> { new_record? }
  validates :password, length: { in: 6..120 }, if: -> { password.present? }
  validates :email, presence: true, uniqueness: true

  has_many :vocabularies, dependent: :destroy, inverse_of: :user

  def send_confirmation_message
    RegistrationMailer.with(user: self).confirmation_email.deliver_later
  end

  def generate_confirmation_token

  end
end
