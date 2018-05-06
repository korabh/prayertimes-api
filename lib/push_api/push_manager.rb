# frozen_string_literal: true

module PushAPI
  # :nodoc:
  class PushManager
    def initialize(client)
      @client = client
    end

    def register(params = {})
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
