# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_secure_password :confirmation_token, validations: false

  enum gender: { female: 1, male: 5, other: 10 }

  validates :first_name, :last_name, :password, presence: true
  validates :password_confirmation, presence: true, if: -> { new_record? }
  validates :password, length: { in: 6..120 }, if: -> { password.present? }
  validates :email, presence: true, uniqueness: true

  has_many :vocabularies, dependent: :destroy, inverse_of: :user

  def remember_token
    token = SecureRandom.urlsafe_base64
    update(remember_token: token)
    token
  end
end
