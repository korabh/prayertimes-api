# frozen_string_literal: true

require 'active_support/all'

class Placeholder
  KEYS = [[:fajr, 2], [:shurooq, 4], [:dhuhr, 6], [:asr, 8],
          [:maghrib, 10], [:isha, 12]].freeze
  def random
    KEYS.each_with_object({}) do |value, hash|
      hash[value.first] = time_travel(minutes: value.last)
    end
  end

  def time_travel(minutes:)
    Time.current.advance(minutes: minutes).to_s(:time)
  end
end
