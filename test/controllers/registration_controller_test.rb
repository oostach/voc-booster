# frozen_string_literal: true

require 'test_helper'

class RegistrationControllerTest < ActionDispatch::IntegrationTest
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
