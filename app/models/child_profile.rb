class ChildProfile < ApplicationRecord
  belongs_to :user
  has_many :child_reviews

  mount_uploader :avatar, AvatarUploader
  validates :avatar, file_size: { less_than: 2.megabytes }

  validates :country, presence: true
  validates :city, presence: true
  validates :birthdate, presence: true
  validates :hobbies, presence: true
  validates :past_year_description, presence: true
  validates :good_deeds, presence: true
end
