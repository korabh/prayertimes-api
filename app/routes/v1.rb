# frozen_string_literal: true

require 'grape-swagger'

module Routes
  module V1
    class API < Grape::API
      version 'v1'
      format :json

      mount Routes::V1::Timing
      mount Routes::V1::Zikir

      add_swagger_documentation \
        mount_path: '/doc'
    end
  end
end
