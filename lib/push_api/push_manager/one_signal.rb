# frozen_string_literal: true
require 'one_signal'
require 'active_support/core_ext/time'
require './lib/push_api/push_manager'

module PushAPI
  # :nodoc:
  class PushManager::OneSignal
    def device(id)
      json_response(
        OneSignal::Player.get(id: id)
      )
    end

    def devices
      json_response(
        OneSignal::Player.all(params: params)
      )
    end

    def notification(id)
      json_response(
        OneSignal::Notification.get(id: id, params: params)
      )
    end

    def notifications
      json_response(
        OneSignal::Notification.all(params: params)
      )
    end

    def create_notification(params = {})
      json_response(
        OneSignal::Notification.create(
          params: {
            url: 'dawa-tools.herokuapp.com',
            headings: { en: params.fetch(:heading) },
            contents: { en: params.fetch(:content) },
            include_player_ids: params.fetch(:include_player_ids),
            send_after: params.fetch(:send_after, Time.now),
            priority: params.fetch(:priority, 5),
            ttl: params.fetch(:ttl, Time.now.seconds_until_end_of_day),
            isAnyWeb: true
          }.merge!(params)
        )
      )
    end

    def delete_notification(id)
      json_response(
        OneSignal::Notification.delete(id: id, params: params)
      )
    end

    private

    def json_response(response)
      JSON.parse(
        response.body,
        symbolize_names: true,
        object_class: OpenStruct
      )
    end

    def params
      { app_id: ENV.fetch('ONESIGNAL_APP_ID') }
    end
  end
end
