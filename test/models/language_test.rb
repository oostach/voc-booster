# frozen_string_literal: true

require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  test 'invalid language without name' do
    language = build(:language, name: '')
    assert_not language.valid?
    assert_includes language.errors.messages_for(:name), 'can\'t be blank'
  end
end
