# frozen_string_literal: true

# :nodoc:
class Dua < ActiveRecord::Base
  belongs_to :zikir, required: true

  translates(
    :title,
    :transliteration,
    :translation,
    :reference
  )

  def self.default_scope
    includes(:translations)
  end
end
