# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.4'

gem 'rails', '~> 7.0.5'

gem 'sprockets-rails'

gem 'pg', '~> 1.1'

gem 'puma', '~> 5.0'

gem 'jsbundling-rails'

gem 'turbo-rails'

gem 'stimulus-rails'

gem 'cssbundling-rails'

gem 'jbuilder'

gem 'redis', '~> 4.0'

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'bootsnap', require: false

gem 'rubocop-rails', require: false

gem 'devise'

gem 'cloudinary'

gem 'activeadmin'

gem 'cancancan'

gem 'sassc-rails'

group :development do
  gem 'bullet'
  gem 'dockerfile-rails', '>= 1.4'
  gem 'web-console'
end

group :development, :test do
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 6.0.0'
end

group :test do
  gem 'selenium-webdriver', '~> 4.4'
  gem 'simplecov', require: false
end
