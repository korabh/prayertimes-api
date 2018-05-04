# frozen_string_literal: true

require 'pry'

# class MessageFormatter
#   attr_reader :key, :period

#   def initialize(key, period)
#     @key = key
#     @period = period
#   end

# end

# class Notification
#   def initialize; end

#   def create; end
# end

# class MessageSender
#   def initialize(client)
#     @client = client
#   end

#   def run
#     t = {
#       fajr: '05:11',
#       dhuhr: '12:44',
#       asr: '16:16',
#       maghrib: '19:06',
#       isha: '20:38'
#     }
#     ts = t.each do |k, v|
#       tp = Time.parse(v)
#       intervals = {
#         0  => tp.advance(seconds: 5),
#         5  => tp.advance(minutes: -5),
#         10 => tp.advance(minutes: -10),
#         15 => tp.advance(minutes: -15),
#       }
#       t[k.to_sym] = intervals
#     end

#     devices = client.devices.players.map { |device| device.id }

#     # a = []
#     ts.each do |key, intervals|
#       _h = intervals.each do |interval, period|
#         f = MessageFormatter.new(key, interval)
#         # a << {heading: f.heading, content: f.content, devices: devices, send_after: period}
#         client.create_notification(
#           f.heading,
#           f.content,
#           include_player_ids: devices,
#           send_after: period
#         )
#       end
#       puts "Completed! at: #{Time.now}"
#     end

#     # binding.pry
#   end

# private

#   attr_reader :client

#   def post_message; end
#   def create_notification(params)
#   end
#   def error_message; end
#   def formatted_message; end
# end

# APP_ID = 'bab46e1e-c306-429f-8fe2-58759077212f'
# client = OneSignalApi.new(APP_ID, 'herokuapp.com')

# job_id = MessageSender.new(client)
# job_id.run

binding.pry

one_signal = WPN::WPNClient::OneSignal.new

client = WPN::WPNClient.new(one_signal)

devices = client.devices.map(&:id)

notifications = WPN::WPNResult.new.call
notifications.each do |k, v|
  notification = WPN::WPNNotification.new(k, v)

  binding.pry

  client.create_notification(
    heading: notification.heading,
    content: notification.content,
    include_player_ids: devices,
    send_after: notification.period
  )

  Rails.logger.info("Added #{notification.id}")
end
