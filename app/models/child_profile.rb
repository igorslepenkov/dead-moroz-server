class ChildProfile < ApplicationRecord
  belongs_to :user

  validates :country, presence: true
  validates :city, presence: true
  validates :birthdate, presence: true
  validates :hobbies, presence: true
  validates :past_year_description, presence: true
  validates :good_deeds, presence: true
end
