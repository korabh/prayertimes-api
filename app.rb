# frozen_string_literal: true

require 'date'
require 'sinatra'

class App < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :erb, layout: :'layouts/default'
  set :public_folder, proc { File.join(root, 'public') }

  helpers do
    def javascript_include_tags(*sources)
      html = ''
      sources.each do |path|
        html << "<script src=\"#{path}\"></script>"
      end
      html
    end

    def stylesheet_include_tags(*sources)
      html = ''
      sources.each do |path|
        html << "<link rel='stylesheet' href=\"#{path}\">"
      end
      html
    end

    def countdown_tag(_name, time)
      current_date = Date.today.strftime('%Y/%m/%d')
      "<div data-countdown=\"#{current_date} #{time}:00\"></div>"
    end

    def countdown(name, time)
      html = ''
      html << "<span>#{name}</span>"
      html << countdown_tag(name, time)
      html
    end

    def current_year
      @current_year ||= Date.today.year
    end
  end

  get '/' do
    date = Date.today.strftime('%d-%m-%Y')
    timings = Timings.find_by_date(date)

    erb :index, locals: { timings: timings }
  end
end
