require "pry"
require "dotenv"
require "one_signal"
require "ostruct"

Dotenv.load

OneSignal::OneSignal.api_key = ENV['ONESIGNAL_API_KEY']
OneSignal::OneSignal.user_auth_key = ENV['ONESIGNAL_USER_AUTH_KEY']

class OneSignalApi
  def initialize(app_id, app_url)
    @app_id = app_id
    @app_url = app_url
  end

  def device(id)
    json_response(
      OneSignal::Player.get(id: id)
    )
  end

  def devices
    json_response(
      OneSignal::Player.all(
        params: {app_id: app_id}
      )
    )
  end

  def notification(id)
    json_response(
      OneSignal::Notification.get(
        id: id, params: {app_id: app_id}
      )
    )
  end

  def notifications
    json_response(
      OneSignal::Notification.all(
        params: {app_id: app_id}
      )
    )
  end

  def create_notification(heading, content, opts = {})
    json_response(
      OneSignal::Notification.create(
        params: {
          app_id: app_id,
          url: app_url,
          headings: {
            en: heading
          },
          contents: {
            en: content
          },
          include_player_ids: opts.fetch(:include_player_ids),
          priority: opts.fetch(:priority, 5)
        }
      )
    )
  end

  def delete_notification(id)
    json_response(
      OneSignal::Notification.delete(
        id: id, params: {app_id: app_id}
      )
    )
  end

  private

  attr_reader :app_id, :app_url

  def json_response(response)
    JSON.parse(
      response.body,
      symbolize_names: true,
      object_class: OpenStruct
    )
  end
end

APP_ID = 'bab46e1e-c306-429f-8fe2-58759077212f'
# client = OneSignalApi.new(APP_ID, 'herokuapp.com')
# client.device('c4a0fea6-8c28-4fff-a35f-a191db070a91')
# client.devices.players.map { |device| device.id }
# client.create_notification(
#   "Parse a JSON API with Ruby",
#   "net/http feels cumbersome and spartan at times.",
#   include_player_ids: [player.id]
# )
# client.notification(id)
# client.notifications
# client.delete_notification(id)

# class MessageSender
#   def initialize()
#   end
# end
#
# class SentMessage
#   def initialize()
#   end
# end
#
