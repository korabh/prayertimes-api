# frozen_string_literal: true

module Routes
  module V1
    class Timing < Grape::API
      get 'timings/random' do
        timings = Placeholder.new
        present :hijri_formatted, Hijri::DateTime.now.strftime('%c')
        present :data, timings.random, with: Entities::V1::Timing
      end

      desc 'Returns all prayer times for a specific date'
      params do
        requires :timestamp, type: Integer
        optional :hide_optional_fields, type: Boolean, default: 'true'
      end
      get 'timings/daily' do
        date = Time.at(params[:timestamp]).strftime('%d-%m-%Y')
        timings = Timings.find_by_date(date)
        present :for, 'daily'
        present :date, date
        present :hijri, timings.hijri
        present :hijri_formatted, Hijri::DateTime.now.strftime('%c')
        present :calculation_method, 'Muslim World League Fajr 18.0 degrees, Isha 17.0 degrees'
        present :juristic_method, 'Standard (Hanbali, Maliki, Shafi)'
        present :daylight, '-/-'
        present :timezone, 'UTC+01:00'
        present :latitude, '42.6629'
        present :longitude, '21.1655'
        present :city, 'Pristina'
        present :country, 'Kosovo'
        present :qibla_direction, '137'
        present :type, 'prayer_times'
        present :data, timings, with: Entities::V1::Timing, optional_fields: params[:hide_optional_fields]
      end

      get 'timings/weekly' do
      end
    end
  end
end
