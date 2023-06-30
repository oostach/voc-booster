# frozen_string_literal: true

class SigninForm
  include ActiveModel::Model

  attr_reader :email, :password

  def initialize(options = ActionController::Parameters.new)
    @email    = options.fetch(:email, '')
    @password = options.fetch(:password, '')
  end

  validates :email, :password, presence: true
  validate :user_exists_and_authenticates

  def user
    @user ||= User.find_by(email: @email)
  end

  def incorrect_user_or_password?
    email.present? && password.present? && errors.key?(:user)
  end

  def user_error
    errors.messages_for(:user).join(' ')
  end

  private

    def user_exists_and_authenticates
      return if email.blank? || password.blank?
      return if user.present? && user.authenticate(password)

      errors.add(:user, 'Email or password is incorrect!')
    end
end