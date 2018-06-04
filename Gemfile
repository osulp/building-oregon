source 'https://rubygems.org'
gem 'coffee-rails'
gem 'email_validator'
gem 'jquery-rails'
gem 'sqlite3'
gem 'rack-timeout'
gem 'rails', '~> 4.1'
gem 'recipient_interceptor'
gem 'sass-rails', '~> 4.0.3'
gem 'simple_form', '3.1.0.rc2'
gem 'uglifier'
gem 'unicorn'
gem 'blacklight', '5.13.1'
gem 'sunspot_rails', '2.1.1'
# Draper for decoration.
gem 'draper', '~> 1.3'
#Carrierwave and Rmagick for photo viewing and storage
gem 'carrierwave'
#Blacklight maps for mapping art pieces
gem 'blacklight-maps', '0.1.0'
#For text editing
gem 'tinymce-rails', '4.0.11'
gem 'passenger'
gem 'capybara', '2.4.3'
gem 'capybara-screenshot', :group => :test
gem "recaptcha", '1.3.0', require: "recaptcha/rails"
gem 'capistrano', '~> 2.0'
gem 'rake', '11.1.0'
gem 'puma', '~> 3.0'

group :development do
gem 'spring'
gem 'spring-commands-rspec'
end

group :development, :test do
gem 'awesome_print'
#gem 'jazz_hands', :github => "terrellt/jazz_hands"
gem 'factory_bot'
gem 'rspec-rails', '~> 2.14.0'
# Test Coverage
gem 'coveralls', :require => false
gem 'simplecov'
end
group :test do
gem 'poltergeist'
gem 'database_cleaner'
gem 'formulaic'
gem 'shoulda-matchers', require: false
gem 'timecop'
gem 'webmock'
end

group :staging, :production do
gem 'newrelic_rpm', '>= 3.7.3'
gem 'mysql2'
end

gem "jettywrapper", "~> 1.7"
gem "devise"
gem "devise-guests", "~> 0.3"
