# frozen_string_literal: true

require 'ostruct'
require 'pathname'
require 'dotenv'

Dotenv.load

Config = OpenStruct.new
Config.env = ENV['RACK_ENV'] ? ENV['RACK_ENV'].to_sym : :development
Config.root = Pathname.new(File.expand_path('..', __dir__))

# Global event subscribers
require 'ruby_event_store'
require 'rails_event_store_active_record'
EventStore = OpenStruct.new
EventStore.client = RubyEventStore::Client.new(repository: RailsEventStoreActiveRecord::EventRepository.new)

# Set One-Signal auth-keys
require 'one_signal'
OneSignal::OneSignal.api_key = ENV.fetch('ONESIGNAL_API_KEY')
OneSignal::OneSignal.user_auth_key = ENV.fetch('ONESIGNAL_USER_AUTH_KEY')

# Load dependencies
require 'bundler'
Bundler.require(:default, Config.env)
