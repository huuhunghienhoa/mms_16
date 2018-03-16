class Position < ApplicationRecord
  validates :name, presence: true, length: {minimum: Settings.position.min_name, maximum: Settings.position.max_name}
  validates :short_name, presence: true, length: {maximum: Settings.position.max_short_name}
  has_many :users
end
