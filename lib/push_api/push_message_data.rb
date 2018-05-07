# frozen_string_literal: true

module PushAPI
  # :nodoc:
  class PushMessageData
    def initialize(salat, timing)
      @salat = salat.to_s
      @timing = timing
    end

    def title
      "Upcoming Prayer: #{salat.capitalize}"
    end

    def message
      case timing.first
      when 5..15
        post_message
      else
        fire_notification
      end
    end

    private

    attr_reader(
      :salat,
      :timing
    )

    def post_message
      "Approximately #{timing.first} minutes"
    end

    def fire_notification
      "Now ##{salat.capitalize} Prayer Time"
    end
  end
end
