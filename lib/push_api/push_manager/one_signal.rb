# frozen_string_literal :true
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
        OneSignal::Player.all(params: app_id)
      )
    end

    def notification(id)
      json_response(
        OneSignal::Notification.get(id: id, params: app_id)
      )
    end

    def notifications
      json_response(
        OneSignal::Notification.all(params: app_id)
      )
    end

    def create_notification(params = {})
      json_response(
        OneSignal::Notification.create(
          params: {
            url: params.fetch(:url, 'dawa-tools.herokuapp.com'),
            headings: { en: params.fetch(:heading) },
            contents: { en: params.fetch(:content) },
            include_player_ids: params.fetch(:include_player_ids),
            send_after: params.fetch(:send_after, Time.now),
            priority: params.fetch(:priority, 10),
            ttl: params.fetch(:ttl, Time.now.advance(minutes: 10)),
            isAnyWeb: true
          }.merge!(app_id)
        )
      )
    end

    def delete_notification(id)
      json_response(
        OneSignal::Notification.delete(id: id, params: app_id)
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

    def app_id
      { app_id: ENV.fetch('ONESIGNAL_APP_ID') }
    end
  end
end
