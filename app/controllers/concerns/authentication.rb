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
    Rails.logger.info(user)
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
    Current.user ||= if session[:user_id]
                       User.find_by(id: session[:user_id])
                     elsif cookies.permanent[:remember_token] && cookies.permanent.signed[:user_id]
                       auth_by_token
                     end
  end

  def auth_by_token
    user = User.find_by(id: cookies.permanent.signed[:user_id])
    user if user.authenticate_remember_token(cookies.permanent[:remember_token])
  end

  def user_signed_in?
    current_user.present?
  end
end
