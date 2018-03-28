require "pry"
require "dotenv"
require "one_signal"
require "ostruct"
require 'active_support/core_ext/time'

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
          chrome_web_icon: "",
          send_after: opts.fetch(:send_after, Time.now),
          priority: opts.fetch(:priority, 5),
          ttl: opts.fetch(:ttl, Time.now.seconds_until_end_of_day), # Time To Live - In seconds. The notification will be expired if the device does not come back online until the end of the day.
          isAnyWeb: true
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

class MessageFormatter
  def initialize(key, period)
    @key = key
    @period = period
  end

  attr_reader :key, :period

  def heading
    "Takvimi: #{_key}".encode!('utf-8')
  end

  def content
    if period == (5 || 10 || 15)
      "#{_key} edhe #{period} minuta."
    else
      "Koha e namazit te #{_key}"
    end
  end

  def _key
    case key
    when :fajr     then "Sabahu"
    when :dhuhr    then "Dreka"
    when :asr      then "Ikindia"
    when :maghrib  then "Akshami"
    when :isha     then "Jacia"
    end
  end

end

class Notification
  def initialize; end

  def create; end
end

class MessageSender
  def initialize(client)
    @client = client
  end

  def run
    t = {
      fajr: '05:14',
      dhuhr: '12:45',
      asr: '16:16',
      maghrib: '19:05',
      isha: '20:37'
    }
    ts = t.each do |k, v|
      tp = Time.parse(v)
      intervals = {
        0  => tp,
        5  => tp.advance(seconds: -5),
        10 => tp.advance(seconds: -10),
        15 => tp.advance(seconds: -15),
      }
      t[k.to_sym] = intervals
    end

    devices = client.devices.players.map { |device| device.id }

    ts.map do |key, intervals|
      _h = intervals.each do |interval, period|
        f = MessageFormatter.new(key, interval)
        client.create_notification(
          f.heading,
          f.content,
          include_player_ids: devices,
          send_after: Time.now # period
        )
      end
      puts "Completed! at: #{Time.now}"
    end
  end

  private

  attr_reader :client

  def post_message; end
  def create_notification(params)
  end
  def error_message; end
  def formatted_message; end
end

APP_ID = 'bab46e1e-c306-429f-8fe2-58759077212f'
client = OneSignalApi.new(APP_ID, 'herokuapp.com')

job_id = MessageSender.new(client)
job_id.run
