# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'invalid user without email' do
    user = build(:user, email: '')
    assert_not user.valid?
    assert_includes user.errors.messages_for(:email), 'can\'t be blank'
  end

  test 'invalid user when email is not unique' do
    user = create(:user)
    user1 = build(:user, email: user.email)
    assert_not user1.valid?
    assert_includes user1.errors.messages_for(:email), 'has already been taken'
  end

  test 'invalid user when password is not confirmation' do
    user = build(:user, password: '111111', password_confirmation: '222222')
    assert_not user.valid?
    assert_includes user.errors.full_messages, 'Password confirmation doesn\'t match Password'
  end

  test 'invalid user when first_name or last_name was not set' do
    user = build(:user, password: '', first_name: '', last_name: '')
    assert_not user.valid?
    assert_includes user.errors.full_messages, 'First name can\'t be blank'
    assert_includes user.errors.full_messages, 'Last name can\'t be blank'
  end

  test 'validate password length only if password set' do
    user = build(:user, password: '')
    assert_not user.valid?
    assert_includes user.errors.full_messages, 'Password can\'t be blank'
    user.password = '111'
    assert_not user.valid?
    assert_includes user.errors.full_messages, 'Password is too short (minimum is 6 characters)'
  end

  test 'brand new user is not confirmed' do
    user = create(:user)
    assert_not_empty user.confirmation_token
    assert_not user.confirmed?, true
  end

  test 'should confirm user' do
    user = create(:user)
    user.confirm!
    assert_nil user.confirmation_token
    assert user.confirmed?, true
  end

  test 'should not generate new confirmation token after update user' do
    user = create(:user)
    user.confirm!
    assert_nil user.confirmation_token
    user.update(first_name: 'Test Name 1')
    assert_nil user.confirmation_token
    assert_equal user.first_name, 'Test Name 1'
  end
end
