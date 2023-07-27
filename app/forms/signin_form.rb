# frozen_string_literal: true

class SigninForm
  include ActiveModel::Model

  attr_reader :email, :password, :remember_me

  def initialize(options = ActionController::Parameters.new)
    @email       = options.fetch(:email, '')
    @password    = options.fetch(:password, '')
    @remember_me = options.fetch(:remember_me, false)
  end

  validates :email, :password, presence: true
  validate :user_exists_and_authenticates
  validate :user_confirmed

  def user
    @user ||= User.find_by(email: @email)
  end

  def incorrect_user_or_password?
    email.present? && password.present? && errors.key?(:user)
  end

  def user_error
    errors.messages_for(:user).join(' ')
  end

  def remember_me?
    @remember_me == '1'
  end

  private

    def user_confirmed
      return if user.confirmed?

      errors.add(:user, I18n.t('.confirm_your_email', scope: 'forms.signin_form'))
    end

    def user_exists_and_authenticates
      return if email.blank? || password.blank?
      return if user.present? && user.authenticate(password)

      errors.add(:user, 'Email or password is incorrect!')
    end
end
