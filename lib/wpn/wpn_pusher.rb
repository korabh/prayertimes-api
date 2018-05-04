# frozen_string_literal: true

require './config/environment'
# require './lib/wpn/wpn_client'
# require './lib/wpn/wpn_client/one_signal'

require './lib/wpn/wpn_result'

# WPN::WPNClient::OneSignal.new()
# WPN::WPNClient.new()
# player_ids = client.devices.players.map(&:id)

require 'pry'; binding.pry

notifications = WPN::WPNResult.new.call
notifications.each do |k, v|
  notification = WPN::WPNNotification.new(k, v)

  client.create_notification(
    heading: notification.heading,
    content: notification.content,
    include_player_ids: player_ids,
    send_after: notification.period
  )

  Rails.logger.info("Added #{notification.id}")
end
