# frozen_string_literal: true

module Routes
  module V1
    class Doowa < Grape::API
      get 'doowa/masnoon' do
        { "masnoon": 'true' }
      end
    end
  end

end