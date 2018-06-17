class Category < ActiveRecord::Base
  translates :name

  validates :name, presence: true
end