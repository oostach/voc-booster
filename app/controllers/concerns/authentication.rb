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
    session[:expires_at] = Time.zone.now + (remember ? 30.days : 1.minutes)
    Current.user = user
  end

  def redirect_not_auth_to_signin
    return sign_out(message: t('session_expired', scope: 'flash.alert')) if session_expired?
    return update_session_expiration if user_signed_in?

    redirect_to signin_path, alert: t('please_signin', scope: 'flash.alert')
  end

  def update_session_expiration
    return if remember?

    session[:expires_at] = 15.minutes.from_now
  end

  def remember?
    Time.zone.parse(session[:expires_at]) - Time.zone.now > 1.hour
  end

  def redirect_to_user_root(with_message: nil)
    redirect_to(root_path, notice: with_message) if user_signed_in?
  end

  def sign_out(message: nil)
    reset_session
    redirect_to(signin_path, alert: message)
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
