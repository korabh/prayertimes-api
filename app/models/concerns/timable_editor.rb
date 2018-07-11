# frozen_string_literal: true

require 'active_support/concern'

module TimableEditor
  extend ActiveSupport::Concern

  module ClassMethods
    def fajr
      time_advance_by(minutes: 40, self.fajr)
    end

    def dhuhr
      time_advance_by(minutes: 16, self.dhur)
    end

    private

    def time_advanced_by(opts, attr)
      time = Time.parse(attr)
      self.attr = time.advance(opts)
    end
  end
end
