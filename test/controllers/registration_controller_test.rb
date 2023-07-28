# frozen_string_literal: true

require 'test_helper'

class RegistrationControllerTest < ActionDispatch::IntegrationTest
  test 'render signup form' do
    get signup_path
    assert_response :success
    assert_match 'Sign up', response.body
  end

  test 'create a new user' do
    post signup_path, params: {
      user: {
        first_name:            'John',
        middle_name:           'Smith',
        last_name:             'Doe',
        email:                 'john@example.com',
        password:              'testtest',
        password_confirmation: 'testtest',
        date_of_birth:         {
          'date_of_birth(1i)' => '2000',
          'date_of_birth(2i)' => '7',
          'date_of_birth(3i)' => '28'
        }
      }
    }
    assert_redirected_to signin_path
    assert_equal 'Thank you for signing up with VocBooster! 🎉. Please confirm your email before signing in.', flash[:notice]
  end

  test 'should not confirm user using invalid token' do
    user = create(:user)
    assert_no_changes -> { user.confirmation_token } do
      get confirmation_url('incorect_token')
      assert_redirected_to signin_path
    end
    assert_not user.confirmed?, true
  end

  test 'should not confirm user using outdated token' do
    user = create(:user)
    travel 61.minutes do
      assert_no_changes -> { user.confirmation_token } do
        get confirmation_url(user.confirmation_token)
        assert_redirected_to signin_path
      end
      assert_not user.confirmed?, true
    end
  end

  test 'should confirm user and redirect to dashboard' do
    user = create(:user)
    assert_changes -> { user.confirmation_token } do
      get confirmation_url(user.confirmation_token)
      assert_redirected_to root_path
      user.reload
    end
    assert user.confirmed?
  end
end
