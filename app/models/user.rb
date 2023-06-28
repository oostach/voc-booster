# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, :password, presence: true
  validates :password_confirmation, presence: true, if: -> { new_record? }
  validates :password, length: { in: 6..120 }
  validates :email, presence: true, uniqueness: true
end
