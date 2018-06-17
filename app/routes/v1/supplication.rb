# frozen_string_literal: true

module Routes
  module V1
    class Supplication < Grape::API
      get 'supplication/masnoon' do
        { "masnoon": 'true' }
      end
    end
  end
end
