class ChildPresent < ApplicationRecord
  belongs_to :child_profile
  belongs_to :user, optional: true

  mount_uploader :image, ChildPresentImageUploader
  validates :image, file_size: { less_than: 2.megabytes }

  validates :name, presence: true

  def alternative?
    user.role != Constants::USER_ROLES[:child]
  end
end
