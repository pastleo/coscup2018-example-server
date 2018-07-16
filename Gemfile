# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Rails Built-in
gem 'rails', '~> 5.2.0'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'bootsnap', '>= 1.1.0', require: false

# User
gem 'devise'
gem 'doorkeeper'
gem 'doorkeeper-jwt'

# Utilities
gem 'oj'
gem 'settingslogic'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'rspec'
  gem 'rspec-rails'

  gem 'factory_bot'
  gem 'faker'

  gem 'shoulda'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'capistrano-rails'

  gem 'brakeman'
  gem 'overcommit'
  gem 'rubocop', '0.56.0'

  gem 'dotenv-rails'
  gem 'pry-rails'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
