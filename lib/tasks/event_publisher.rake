# frozen_string_literal: true

require './config/application'

namespace :event do
  task :publisher do
    # Event Generator – pushes an event to a consumer when the generator detects a relevant state change.
    # Event Consumers – consumes and acts on the events produced by generators.
    # Event Channel – a mechanism whereby the information from an event
    # generator is transferred to the event engine.
    # Event Processing Engine – an event is processed and a subsequent action is taken.
    # Downstream Event-Driven Activity – the downstream consequences triggered by the event-driven action.

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
  end
end
