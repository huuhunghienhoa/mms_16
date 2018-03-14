class User < ApplicationRecord
  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users
  has_many :skill_users, dependent: :destroy
  has_many :skills, through: :skill_users
  belongs_to :team
  belongs_to :position
end
