# frozen_string_literal: true

module Entities
  module V1
    # :nodoc:
    class Dua < Grape::Entity
      expose :title
      expose :arabic
      expose :transliteration
      expose :translation
      expose :reference
    end

    # :nodoc:
    class Zikir < Grape::Entity
      expose :id
      expose :name
      expose :url
      expose :duas, using: Entities::V1::Dua
    end
  end
end
