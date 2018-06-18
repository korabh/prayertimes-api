# frozen_string_literal: true

# :nodoc:
class Zikir < ActiveRecord::Base
  translates :name

  validates :name, presence: true

  has_many :duas

  def self.default_scope
    includes(:duas, :translations)
  end
end
