# frozen_string_literal: true

#
# Helper module to suport session for the integration and system tests.
#
module Authenticator
  #
  # Method for verifying whether we have an active user session.
  #
  # @return [Boolean] Returns true if a test user is logged in.
  #
  def signed_in?
    session[:user_id].present?
  end

  #
  # Method to create user session for the integration and system tests.
  #
  # @param user [<User>] user should be signed in
  # @param options [<Hash>] additional options to configure a session
  # @option options :password [String] custom password for the user
  # @option options :remember_me [String] remember option to enable persistent session
  #
  # @return [<void>]
  #
  def sign_in_as(user, options = {})
    password    = options[:password]    || 'testtest'
    remember_me = options[:remember_me] || '1'

    post signin_path, params: {
      signin_form: {
        email:       user.email,
        password:    password,
        remember_me: remember_me
      }
    }
    follow_redirect!
  end

  private

    def integration_test?
      defined?(post_via_redirect)
    end
end
