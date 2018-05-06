# frozen_string_literal: true

module PushAPI
  class PushMessageData
    attr_reader :key, :period

    def initialize(key, period)
      @key = key
      @period = period
    end

    def heading
      "Upcoming Prayer: #{_key}".encode!('utf-8')
    end

    def content
      if period == 5 || period == 10 || period == 15
        "#{period} minutes to #{_key} prayer"
      else
        "#{_key} :)"
      end
    end

    def _key
      key.to_s.capitalize
    end

    def error_message; end

    def formatted_message; end
  end
end
