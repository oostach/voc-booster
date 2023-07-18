# frozen_string_literal: true

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'invalid category without name' do
    category = build(:category, name: '')
    assert_not category.valid?
    assert_includes category.errors.messages_for(:name), 'can\'t be blank'
  end
end
