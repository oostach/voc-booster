# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :redirect_not_auth_to_signin
    helper_method :current_user, :user_signed_in?
  end

  def sign_in(user, remember)
    reset_session
    session[:user_id] = user.id
    session[:expires_at] = Time.zone.now + (remember ? 30.days : 15.minutes)
    Current.user = user
  end

  def redirect_not_auth_to_signin
    return sign_out if session_expired?
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

  def session_expired?
    return false unless session[:expires_at]

    Time.zone.parse(session[:expires_at]) < Time.zone.now
  end

  def current_user
    Current.user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end
end
