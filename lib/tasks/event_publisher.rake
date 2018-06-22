# frozen_string_literal: true

require './config/application'
require 'rails_event_store_active_record'
require 'ruby_event_store'

namespace :event do
  task :publisher do
    create_events_tables!

    class DailyReminder < RubyEventStore::Event
    end

    event_store = RubyEventStore::Client.new(
      repository: RailsEventStoreActiveRecord::EventRepository.new
    )
    action_data = {
      data: {
        trigger_identity: '92429d82a41e93048',
        trigger_source: {
          label: 'on_hearing_athan',
          value: '41'
        },
        submitted_at: Time.now,
        calculated: {
          score: 10
        }
      }
    }
    event_store.append_to_stream(
      DailyReminder.new(action_data),
      stream_name: 'Id-92429d82a41e93048'
    )

    require 'pry'; binding.pry
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
