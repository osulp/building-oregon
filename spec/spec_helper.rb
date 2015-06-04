ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
require 'coveralls'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start 'rails'

require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'shoulda/matchers'
require 'webmock/rspec'
require 'capybara/poltergeist'
require 'capybara/rails'
require 'capybara/rspec'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |file| require file }

module Features
  # Extend this modeule in spec/support/features/*.rb
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Features, type: :feature
  config.include Formulaic::Dsl, type: :feature
  config.include Capybara::DSL
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.use_transactional_fixtures = false
end

ActiveRecord::Migration.maintain_test_schema!
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :timeout => 60,:phantomjs_options => ['--proxy-type=socks5', '--proxy=0.0.0.0:0'])
end
Capybara.javascript_driver = :poltergeist
WebMock.disable_net_connect!(allow_localhost: true)
