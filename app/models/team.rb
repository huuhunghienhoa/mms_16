class Team < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :leader_id, presence: true
  validate :logo_size

  has_many :users
  has_many :projects, dependent: :destroy
  belongs_to :leader, class_name: User.name, foreign_key: :leader_id

  scope :newest, ->{order(created_at: :desc)}

  accepts_nested_attributes_for :users, allow_destroy: true

  mount_uploader :logo, LogoUploader

  def logo_size
    errors.add :logo, I18n.t("upload.mess_limit_size") if logo.size > Settings.upload.max_size.megabytes
  end
end
