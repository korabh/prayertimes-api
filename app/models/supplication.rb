# frozen_string_literal: true

class Supplication < ActiveRecord::Base
  self.table_name = 'duas'

  belongs_to :category, required: true

  translates(
    :title,
    :transliteration,
    :translation,
    :reference
  )
end
