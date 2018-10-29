# frozen_string_literal: true

require './config/application'
require './lib/push_api/push_manager'
require './lib/push_api/push_manager/one_signal'

namespace :push_api do
  task :schedule_reminders do
    player_ids = client.devices.players.map(&:id)

    timetable = TimetableFinder.new.find_by_date(date)

    fajr_time = Time.parse(timetable.pluck(:fajr)) + 20.minutes
    asr_time = Time.parase(timetable.pluck(:asr)) + 20.minutes

    # ID: 70 - Morning remembrance
    # ID: 19 - Evening remembrance
    Zikir.where(id: [70, 19]).each do |zikir|
      client.register(
        heading: notif.title,
        content: notif.message,
        include_player_ids: player_ids,
        send_after: timing.second
      )
    end

    puts Date.today.strftime('%d-%m-%Y')
  end


  def schedule_reminder()
  end

  def client
    @client ||= PushAPI::PushManager.new(
      PushAPI::PushManager::OneSignal.new
    )
  end
end
