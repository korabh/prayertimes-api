# frozen_string_literal: true

module Routes
  module V1
    # :nodoc:
    class Zikir < Grape::API
      get 'zikirs' do
        zikirs = ::Zikir.all
        present :data, zikirs, with: Entities::V1::Zikir
      end

      get 'zikirs/:zikir_id' do
        zikir = ::Zikir.where(id: params['zikir_id']).first

        if zikir.present?
          present :data, zikir, with: Entities::V1::Zikir
        else
          present :status, 404
          present :errors, "Couldn't find Dua with 'id'=#{params['dua_id']}"
        end
      end
    end
  end
end
