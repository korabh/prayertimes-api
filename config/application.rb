# frozen_string_literal: true

require './config/environment'
$LOAD_PATH.unshift Config.root.join('lib')

OTR::ActiveRecord.configure_from_file! Config.root.join('config', 'database.yml')

[
  %w[app models ** *.rb],
  %w[app entities ** *.rb],
  %w[app routes v* *.rb],
  %w[app routes ** *.rb],
  %w[lib ** *.rb],
  %w[lib push_api *.rb],
  %w[lib push_api ** *.rb]
].each do |pattern|
  Dir.glob(Config.root.join(*pattern)).each { |file| require file }
end
