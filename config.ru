# frozen_string_literal: true

require './config/application'
require './app'

use OTR::ActiveRecord::ConnectionManagement
use Rack::Session::Cookie

run Rack::Cascade.new([
                        Routes::V1::API,
                        # add web-view.
                        App
                      ])
