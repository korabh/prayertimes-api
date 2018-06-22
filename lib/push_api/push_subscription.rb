# frozen_string_literal: true

require 'active_support/core_ext/time'

module PushAPI
  # :nodoc:
  class PushSubscription
    def self.call(data)
      new(data).call
    end

    def call
      build!
    end

    private

    def initialize(data)
      @data = data
    end

    attr_reader :data

    def build!
      raise if attributes.blank?

      hash = {}
      attributes.each do |key, value|
        time = Time.parse(value)
        hash[key.to_sym] = scheduled_time(time)
      end
      hash
    end

    def attributes
      data.slice(:fajr, :dhuhr, :asr, :maghrib, :isha)
    end

    def scheduled_time(time)
      {
        0  => time.advance(seconds: 5),
        10 => time.advance(minutes: -10)
      }
    end
  end
end
