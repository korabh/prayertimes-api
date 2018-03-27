require "pry"
require "dotenv"
require "one_signal"

OneSignal::OneSignal.api_key = "NjU4NjI1ZDAtNjJhOS00YmFjLTk5YmQtNGJiNjUyODY3MGI4" # ENV['ONESIGNAL_API_KEY']
OneSignal::OneSignal.user_auth_key = "MDQxZTJiZjktNjVkNi00NTRhLWE5NjYtNDlmMmM4YjkwNDBi" # ENV['ONESIGNAL_USER_AUTH_KEY']
APP_ID = "bab46e1e-c306-429f-8fe2-58759077212f"

response = OneSignal::Player.all(params: {app_id: APP_ID})
response = JSON.parse(
  response.body,
  symbolize_names: true
)
player_ids = response[:players].collect { |player| player[:id] }
params = {
  app_id: APP_ID,
  contents: {
    en: 'Yeiiiii!'
  },
  include_player_ids: player_ids
}
begin
  OneSignal::Notification.create(params: params)
  puts "--- created app id: #{APP_ID}"
rescue OneSignal::OneSignalError => e
  puts "-- OneSignalError  :"
  puts "-- message : #{e.message}"
  puts "-- status : #{e.http_status}"
  puts "-- body : #{e.http_body}"
end
