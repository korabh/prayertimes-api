# frozen_string_literal: true

require './config/application'
require 'ostruct'
require 'json'

namespace :db do
  task :seed do
    puts Date.today.strftime('%d-%m-%Y')

    unless table_exists?(:zikirs) && table_exists?(:duas)
      ActiveRecord::Base.connection.create_table(:zikirs) do |t|
        t.string :name, null: false, default: ''
        t.string :url
      end
      ActiveRecord::Base.connection.create_table(:duas) do |t|
        t.references :zikir, index: true
        t.string :title, null: false, default: ''
        t.string :arabic
        t.string :transliteration
        t.string :translation
        t.string :reference
      end

      create_translation_tables!
    end

    results.each do |result|
      zikir = Zikir.new.tap do |z|
        z.name = result.name
        z.url = result.url
        z.save!
      end

      next if result.duas.blank?

      result.duas.each do |dd|
        dua = Dua.new(
          zikir_id: zikir.id,
          title: dd.title,
          arabic: dd.arabic,
          transliteration: dd.transliteration,
          translation: dd.translation,
          reference: dd.reference
        )
        dua.save!

        puts "Added #{zikir.name} - #{dua.title}"
      end
    end
  end

  def results
    payload = JSON.parse(
      File.read('run_results.json'),
      object_class: OpenStruct
    )
    payload.data
  end

  def table_exists?(table)
    ActiveRecord::Base.connection.table_exists?(table.to_sym)
  end

  def create_translation_tables!
    Zikir.create_translation_table!(
      name: :string
    )
    Dua.create_translation_table!(
      title: :string,
      transliteration: :string,
      translation: :string,
      reference: :string
    )
  end
end
