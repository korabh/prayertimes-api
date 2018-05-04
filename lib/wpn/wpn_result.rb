# frozen_string_literal: true

require 'rest-client'
require 'json'
require 'active_support/core_ext/time'

module WPN
  # :nodoc:
  class WPNResult
    HEROKUAPP = 'dawa-tools.herokuapp.com'

    def call
      fetch!
    end

    private

    def fetch!
      RestClient.get(
        "#{HEROKUAPP}/v1/timings/daily",
        params: { timestamp: Time.now.to_i }
      ).tap do |response|
        payload = JSON.parse(response.body)
        build_hash(payload['data'])
      end
    end

    def build_hash(data)
      hash = {}
      data.each do |key, value|
        time = Time.parse(value)
        hash[key.to_sym] = {
          0  => time.advance(seconds: 5),
          5  => time.advance(minutes: -5),
          10 => time.advance(minutes: -10),
          15 => time.advance(minutes: -15)
        }
      end
      hash
    end

    def post_message; end
  end
end
