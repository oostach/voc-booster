# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start 'rails' do
    coverage_dir 'tmp/coverage'
  end
end

require_relative '../config/environment'
require 'rails/test_help'

Dir[Rails.root.join('test/support/**/*.rb')].each { |f| require f }

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  include FactoryBot::Syntax::Methods
  include Rails.application.routes.url_helpers
  include Authenticator
  include CommonExtension

  def default_url_options
    Rails.application.config.action_mailer.default_url_options
  end
end
