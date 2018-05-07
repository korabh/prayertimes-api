# frozen_string_literal: true

require './config/application'

require './lib/push_api/push_manager'
require './lib/push_api/push_manager/one_signal'

namespace :push_api do
  task :notifications do
    one_signal = PushAPI::PushManager::OneSignal.new
    pm = PushAPI::PushManager.new(one_signal)

    player_ids = pm.devices.players.map(&:id)
    today = Time.now.strftime('%d-%m-%Y')
    subscriptions = PushAPI::PushSubscription.call(Timings.find_by_date(today))

    subscriptions.each do |salat, timings|
      timings.each do |timing|
        pmd = PushAPI::PushMessageData.new(salat, timing)

        pm.register(
          heading: pmd.title,
          content: pmd.message,
          include_player_ids: player_ids,
          send_after: timing.second
        )
      end
    end

    Rails.logger.info(Date.today.strftime('%d-%m-%Y'))
  end
end
