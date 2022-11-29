class ChildReview < ApplicationRecord
  belongs_to :child_profile

  validates :score, inclusion: { in: 0..10 }
  validates :comment, length: { minimum: 10 }
end
