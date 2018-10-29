# frozen_string_literal: true

require './config/application'
require './lib/push_api/push_manager'
require './lib/push_api/push_manager/one_signal'

namespace :push_api do
  task :schedule_notifications do
    player_ids = client.devices.players.map(&:id)

    timetable = TimetableFinder.new.find_by_date(Date.today)
    notifications = PushAPI::PushSubscription.call(timetable)

    notifications.each do |key, timings|
      timings.each do |timing|
        notif = PushAPI::PushMessageData.new(key, timing)

        client.register(
          heading: notif.title,
          content: notif.message,
          include_player_ids: player_ids,
          send_after: timing.second
        )
      end
    end
    puts Date.today.strftime('%d-%m-%Y')
  end

  def client
    @client ||= PushAPI::PushManager.new(
      PushAPI::PushManager::OneSignal.new
    )
  end
end
