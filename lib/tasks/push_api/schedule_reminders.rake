# frozen_string_literal: true

require './config/application'
require './lib/utils'
require './lib/push_api/push_manager'
require './lib/push_api/push_manager/one_signal'

namespace :push_api do
  task :schedule_reminders do
    player_ids = client.devices.players.map(&:id)

    timetable = TimetableFinder.new.find_by_date(
      Date.today
    )
    morning = ttl(timetable.fajr)
    evening = ttl(timetable.asr)
    [
      [morning, Zikir.find(70)],
      [evening, Zikir.find(19)]
    ].each do |remembrance|
      content = "Read Duas about #{remembrance[1].name.downcase}"

      client.register(
        heading: remembrance[1].name,
        content: content,
        include_player_ids: player_ids,
        send_after: remembrance[0]
      )
    end
    puts Date.today.strftime('%d-%m-%Y')
  end

  def ttl(key, minutes = 25)
    Utils.time_advanced(key, minutes: minutes)
  end

  def client
    @client ||= PushAPI::PushManager.new(
      PushAPI::PushManager::OneSignal.new
    )
  end
end
