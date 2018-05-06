# frozen_string_literal: true

require './config/application'

require './lib/push_api/push_manager'
require './lib/push_api/push_manager/one_signal'

one_signal = PushAPI::PushManager::OneSignal.new
pm = PushAPI::PushManager.new(one_signal)

player_ids = pm.devices.players.map(&:id)

today = Time.now.strftime('%d-%m-%Y')
subscriptions = PushAPI::PushSubscription.call(Timings.find_by_date(today))

subscriptions.each do |key, v|
  pmd = PushAPI::PushMessageData.new(key, v)
  require 'pry'; binding.pry
  pm.register(
    heading: pmd.heading,
    content: pmd.content,
    include_player_ids: player_ids,
    send_after: pmd.period
  )
end
Rails.logger.info('Completed!')
