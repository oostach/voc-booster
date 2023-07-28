# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should render sign in form' do
    get signin_path
    assert_response :success
    assert_match 'Sign in', response.body
    assert_match 'Forgot your password?', response.body
  end

  test 'should sign in a user and redirect to dashboard' do
    user = create(:user, :confirmed)
    assert user.confirmed?
    post signin_path, params: { signin_form: { email: user.email, password: 'testtest' } }
    assert_redirected_to root_path
  end

  test 'should not sign in an unconfirmed user' do
    user = create(:user)
    assert_not user.confirmed?
    post signin_path, params: { signin_form: { email: user.email, password: 'testtest' } }
    assert_response :success
    assert_match 'Please confirm your email before sign in.', response.body
  end

  test 'should sign out a user' do
    user = create(:user, :confirmed)
    sign_in_as(user)
    delete signout_path
    assert_redirected_to signin_path
  end

  test 'should redirect user to signin path if user is not signin' do
    get root_path
    assert_redirected_to signin_path
  end
end
