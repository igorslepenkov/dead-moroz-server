class ChildReview < ApplicationRecord
  belongs_to :child_profile
  belongs_to :user

  has_many :child_presents

  validates :score, inclusion: { in: 0..10 }
  validates :comment, length: { minimum: 10 }
  validates :user_id, uniqueness: { message: ', you have already reviewed this profile' }
end
