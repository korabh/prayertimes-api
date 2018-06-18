# frozen_string_literal: true

require 'rspec/core'
require 'rspec/core/rake_task'
require 'active_record'

load './lib/tasks/push_api.rake'
load './lib/tasks/seed.rake'

RSpec::Core::RakeTask.new(:spec)
OTR::ActiveRecord.migrations_paths = ['db/migrate']

namespace :db do
  task :environment do
    require_relative 'config/application'
  end
end

task default: :spec
task test: :spec
