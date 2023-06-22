# frozen_string_literal: true

require 'application_system_test_case'

class DashboardsTest < ApplicationSystemTestCase
  test 'visiting the index' do
    visit root_path

    assert_selector 'h1', text: 'Dashboard'
  end
end
