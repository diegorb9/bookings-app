# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 6.0.0'

gem 'sass-rails', '~> 5'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

gem 'bootsnap', '>= 1.4.2', require: false

gem 'cancan', '~> 1.6.10'
gem 'devise', '~> 4.7.1'
gem 'simple_form', '~> 5.0.1'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', '~> 0.75.1', require: false
  gem 'spring', '~> 2.1.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'rails-controller-testing', '~> 1.0.4'
  gem 'selenium-webdriver', '~> 3.142.6'
  gem 'shoulda-matchers', '~> 4.1'
  gem 'simplecov', require: false
  gem 'timecop', '~> 0.9.1'
  gem 'webdrivers', '~> 4.1.3'
end

group :development, :test do
  gem 'dotenv-rails', '~> 2.7.5'
  gem 'factory_bot_rails', '~> 5.1.1'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 4.0.0.beta3'
end
