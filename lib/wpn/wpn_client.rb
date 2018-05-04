# frozen_string_literal: true

module WPN
  # :nodoc:
  class WPNClient
    def initialize(client)
      @client = client
    end

    def payload_send(params = {})
      client.create_notification(params)
    end

    def notifications
      client.notifications
    end

    def devices
      client.devices
    end

    private

    attr_reader :client
  end
end
