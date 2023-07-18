# frozen_string_literal: true

require 'test_helper'

class ExpressionTest < ActiveSupport::TestCase
  test 'invalid expression without content' do
    expression = build(:expression, content: '')
    assert_not expression.valid?
    assert_includes expression.errors.messages_for(:content), 'can\'t be blank'
  end

  test 'clear category for the expressions when the category is deleted' do
    category   = create(:category)
    expression = create(:expression, category: category)
    assert_equal expression.category, category
    category.destroy
    assert_nil expression.reload.category
  end
end
