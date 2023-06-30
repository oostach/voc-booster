# frozen_string_literal: true

class SigninForm
  include ActiveModel::Model

  attr_accessor :email, :password

  def initialize(email: nil, password: nil)
    @email    = email
    @password = password
  end

  validates :email, :password, presence: true
end