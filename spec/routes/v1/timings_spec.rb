# frozen_string_literal: true

require 'spec_helper'
require 'hijri'

describe Routes::V1::Timing do
  include Rack::Test::Methods

  def app
    Routes::V1::API
  end

  describe 'GET /api/v1/timings' do
    it 'returns all prayer times for a specific date' do
      get '/v1/timings/daily', timestamp: 1_481_929_200, hide_optional_fields: false

      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(
        {
          "for": 'daily',
          "date": '17-12-2016',
          "hijri": '17-03-1438',
          "hijri_formatted": Hijri::DateTime.now.strftime('%c'),
          "calculation_method": 'Muslim World League Fajr 18.0 degrees, Isha 17.0 degrees',
          "juristic_method": 'Standard (Hanbali, Maliki, Shafi)',
          "daylight": '-/-',
          "timezone": 'UTC+01:00',
          "latitude": '42.6629',
          "longitude": '21.1655',
          "city": 'Pristina',
          "country": 'Kosovo',
          "qibla_direction": '137',
          "type": 'prayer_times',
          "data": {
            "fajr": '05:45',
            "shurooq": '06:56',
            "dhuhr": '11:37',
            "asr": '13:57',
            "maghrib": '16:12',
            "isha": '17:51'
          }
        }.to_json
      )
    end

    it 'returns prayer times for a specific week' do
    end

    it 'returns prayer times for a specific month' do
    end

    it 'UNIX timestamp for the specified time zone' do
    end

    it 'returns a 404 error if timestamp is not provided' do
    end
  end
end
