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

  test 'should update session expiration on each request' do
    user = create(:user, :confirmed)
    sign_in_as(user, { remember_me: '0' })

    travel 10.minutes do
      assert_equal 5.minutes.from_now.strftime('%H:%M'), session[:expires_at].round.strftime('%H:%M')
      get root_path
      assert_equal 15.minutes.from_now.strftime('%H:%M'), session[:expires_at].round.strftime('%H:%M')
    end
  end

  test 'should auto logout user if session is expired' do
    user = create(:user, :confirmed)
    sign_in_as(user, { remember_me: '0' })
    get root_path
    assert_response :success

    travel 20.minutes do
      get root_path
      assert_redirected_to signin_path
      assert_equal 'Your session has been expired, please sign in to continue.', flash[:alert]
    end
  end

  test 'extend session with remember_me option to 30 days' do
    user = create(:user, :confirmed)
    sign_in_as(user, { remember_me: '1' })
    assert 30, Time.zone.parse(session[:expires_at]) - Time.zone.now
  end
end
