# frozen_string_literal: true

require './config/application'
require 'ruby_event_store'
require 'rails_event_store_active_record'

namespace :event do
  task :publisher do
    create_events_tables!

    event_data = {
      data: {
        label: 'on_hearing_athan',
        value: '41',
        started_at: Time.now,
        calculated: {
          score: 10
        }
      }
    }
    EventStore.client.publish_event(
      DailyReminder.new(event_data),
      stream_name: 'on_hearing_athan'
    )
  end

  def create_events_tables!
    unless ActiveRecord::Base.connection.table_exists?(:event_store_events)
      ActiveRecord::Base.connection.create_table(:event_store_events, id: false) do |t|
        t.string :id, limit: 36, primary_key: true, null: false, index: true
        t.string      :event_type, null: false
        t.text        :metadata
        t.text        :data,        null: false
        t.datetime    :created_at,  null: false
      end
    end
    unless ActiveRecord::Base.connection.table_exists?(:event_store_events_in_streams)
      ActiveRecord::Base.connection.create_table(:event_store_events_in_streams, id: false) do |t|
        t.string      :id, limit: 36, primary_key: true, null: false
        t.string      :stream,      null: false, unique: true, index: true
        t.integer     :position,    null: true, unique: true, index: true
        t.references  :event, null: false, type: :string, index: true
        t.datetime    :created_at,  null: false
      end
    end
  end
end
