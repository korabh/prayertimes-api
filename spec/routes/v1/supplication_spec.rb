# frozen_string_literal: true

require 'spec_helper'

describe Routes::V1::Supplication do
  include Rack::Test::Methods

  def app
    Routes::V1::API
  end

  describe 'Supplication API' do
    describe 'GET /api/v1/supplication/masnoon' do
      describe 'when request is valid' do
        it 'returns the list of masnoon duas' do
          get 'v1/supplication/masnoon'
          expect(last_response.status).to eq(200)
          expect(last_response.body).to eq(
            {
              "masnoon": 'true'
            }.to_json
          )
        end
      end
    end
  end
end
