class ChildProfile < ApplicationRecord
  belongs_to :user

  mount_uploader :avatar, AvatarUploader

  validates :country, presence: true
  validates :city, presence: true
  validates :birthdate, presence: true
  validates :hobbies, presence: true
  validates :past_year_description, presence: true
  validates :good_deeds, presence: true
  validates :avatar, presence: true
end
