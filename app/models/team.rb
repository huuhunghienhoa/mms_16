class Team < ApplicationRecord
  has_many :users
  has_many :projects, dependent: :destroy
  belongs_to :leader, class_name: User.name, foreign_key: :leader_id
end
