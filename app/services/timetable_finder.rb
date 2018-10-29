# frozen_string_literal: true

# :nodoc:
class TimetableFinder
  def initialize(strftime = '%d-%m-%Y')
    @strftime = strftime
  end

  def find_by_date(date = Time.now)
    date = date.strftime(strftime)

    Timings.find_by_date(date)
  end

  private

  attr_reader :strftime
end
