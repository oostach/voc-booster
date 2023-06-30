# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :verify_user
    helper_method :current_user, :user_signed_in?
  end

  def sign_in(user)
    reset_session
    session[:user_id] = user.id
    Current.user = user
  end

  def verify_user
    return if user_signed_in?

    redirect_to signin_path, alert: 'Please sign in to access this resource!'
  end

  def sign_out
    reset_session
  end

  def current_user
    Current.user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end
end
