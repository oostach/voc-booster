# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :redirect_not_auth_to_signin
    helper_method :current_user, :user_signed_in?
  end

  def sign_in(user)
    reset_session
    session[:user_id] = user.id
    Current.user = user
  end

  def remember(user)
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)

  end

  def redirect_not_auth_to_signin
    return if user_signed_in?

    redirect_to signin_path, alert: 'Please sign in to access this resource!'
  end

  def redirect_to_user_root(with_message: nil)
    redirect_to(root_path, notice: with_message) if user_signed_in?
  end

  def sign_out
    reset_session
    redirect_to signin_path
  end

  def current_user
    Current.user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end
end
