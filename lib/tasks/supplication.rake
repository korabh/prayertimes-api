# frozen_string_literal: true

require './config/application'
require 'ostruct'
require 'json'

namespace :seed do
  task :supplication do
    puts Date.today.strftime('%d-%m-%Y')

    unless table_exists?(:categories) && table_exists?(:duas)
      ActiveRecord::Base.connection.create_table(:categories) do |t|
        t.string :name, null: false, default: ''
        t.string :url
      end
      ActiveRecord::Base.connection.create_table(:duas) do |t|
        t.references :category, index: true
        t.string :title, null: false, default: ''
        t.string :arabic
        t.string :transliteration
        t.string :translation
        t.string :reference
      end

      create_translation_tables!
    end

    results.each do |result|
      category = Category.new.tap do |c|
        c.name = result.name
        c.url = result.url
        c.save!
      end

      next if result.duas.blank?

      result.duas.each do |dd|
        supplication = Doowa.new(
          category_id: category.id,
          title: dd.title,
          arabic: dd.arabic,
          transliteration: dd.transliteration,
          translation: dd.translation,
          reference: dd.reference
        )
        supplication.save!

        puts "Added #{category.name} - #{supplication.title}"
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
    Category.create_translation_table!(
      name: :string
    )
    Supplication.create_translation_table!(
      title: :string,
      transliteration: :string,
      translation: :string,
      reference: :string
    )
  end
end
