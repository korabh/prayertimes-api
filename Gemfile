# frozen_string_literal: true

source 'http://rubygems.org'

ruby '2.3.1'

gem 'activerecord', '~> 4.2.7', require: 'active_record'
gem 'dotenv'
gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'
gem 'grape-swagger'
gem 'grape-swagger-entity'
gem 'hijri'
gem 'one_signal'
gem 'otr-activerecord'
gem 'pry'
gem 'rack-cors'
gem 'rake'
gem 'rest-client'
gem 'rubocop', '~> 0.55.0', require: false
gem 'sinatra', github: 'sinatra/sinatra'

group :development, :test do
  gem 'pg'
end

group :test do
  gem 'capybara'
  gem 'rack-test'
  gem 'rspec'
  gem 'selenium-webdriver'
end

group :production do
  gem 'pg'
end
