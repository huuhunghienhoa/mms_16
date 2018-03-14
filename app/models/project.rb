class Project < ApplicationRecord
  belongs_to :team
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
end
