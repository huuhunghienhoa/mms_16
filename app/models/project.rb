class Project < ApplicationRecord
  belongs_to :team
  belongs_to :leader, class_name: User.name, foreign_key: :leader_id
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users

  validates :name, presence: true, length: {minimum: Settings.project.min_name}
  validates :date_start, presence: true
  validates :date_end, presence: true

  scope :newest, ->{order(created_at: :desc)}
  scope :search, ->(param){where "team_id = ?", param}
end
