# frozen_string_literal: true

require './lib/utils'
require './config/application'
require './lib/push_api/push_manager'
require './lib/push_api/push_manager/one_signal'

namespace :push_api do
  task :schedule_reminders do
    player_ids = client.devices.players.map(&:id)

    timetable = TimetableFinder.new.find_by_date(
      Date.today
    )
    morning = send_after(timetable.fajr, 20)
    evening = send_after(timetable.asr)
    [
      [morning, Zikir.find(70)],
      [evening, Zikir.find(19)]
    ].each do |remembrance|
      content = "Read Duas about #{remembrance[1].name.downcase}"

      client.register(
        heading: remembrance.second.name,
        content: content,
        include_player_ids: player_ids,
        send_after: remembrance.first,
        url: web_url(remembrance.second.id)
      )
    end
    puts Date.today.strftime('%d-%m-%Y')
  end

  def web_url(zikir_id)
    "http://dawa-tools.herokuapp.com/zikirs/#{zikir_id}"
  end

  def send_after(key, minutes = 25)
    include Utils
    time_advanced(key, minutes: minutes)
  end

  def client
    @client ||= PushAPI::PushManager.new(
      PushAPI::PushManager::OneSignal.new
    )
  end
end
