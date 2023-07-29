# frozen_string_literal: true

class User < ApplicationRecord
  CONFIRMATION_TOKEN_EXPIRATION = 60.minutes

  has_secure_password
  has_secure_token :confirmation_token, length: 36
  has_one_attached :photo

  enum gender: { female: 1, male: 5, other: 10 }

  validates :first_name, :last_name, :password, presence: true
  validates :password_confirmation, presence: true, if: -> { new_record? }
  validates :password, length: { in: 6..120 }, if: -> { password.present? }
  validates :email, presence: true, uniqueness: true

  has_many :vocabularies, dependent: :destroy, inverse_of: :user

  after_create :send_confirmation_message

  def send_confirmation_message
    RegistrationMailer.with(user: self).confirmation_email.deliver_later
  end

  def confirmation_token_outdated?
    created_at + CONFIRMATION_TOKEN_EXPIRATION < Time.zone.now
  end

  def confirm!
    update_attribute(:confirmation_token, nil) # rubocop:disable Rails/SkipsModelValidations
  end

  def confirmed?
    confirmation_token.blank?
  end

  def full_name
    [first_name, last_name].compact.join(' ')
  end
end
