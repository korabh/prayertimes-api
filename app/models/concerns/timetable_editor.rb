# frozen_string_literal: true

require './lib/utils'
require 'active_support/concern'

# :nodoc:
module TimetableEditor
  include Utils
  extend ActiveSupport::Concern

  included do
    # Specify the table name
    self.table_name = 'kosova'
  end

  def fajr
    time = time_advanced(read(:fajr), minutes: 40)
    change(:fajr, time)
  end

  def dhuhr
    time = time_advanced(read(:dhuhr), minutes: 36)
    change(:dhuhr, time)
  end
end
