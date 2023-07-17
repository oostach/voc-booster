source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '3.2.2'

gem 'rails', '~> 7.0.5'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'jbuilder'
gem 'redis', '~> 4.0'
gem 'image_processing', '~> 1.2'
gem 'bcrypt', '~> 3.1.7'
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]
gem 'bootsnap', require: false
gem 'i18n_data'

gem 'sprockets-rails'
gem 'turbo-rails'
gem "stimulus-rails"
gem 'haml-rails'
gem 'simple_form'

# gem "jsbundling-rails"
# gem "sassc-rails"
# gem "kredis"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'letter_opener'
end

group :development do
  gem 'solargraph'
  gem 'solargraph-rails'
  gem 'web-console'
  gem 'rack-mini-profiler'
  gem 'rubocop-rails'
  gem 'rubocop-capybara'
  gem 'rubocop-factory_bot'
  gem 'haml_lint', require: false
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'simplecov', require: false
end
