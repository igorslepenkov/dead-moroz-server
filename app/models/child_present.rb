class ChildPresent < ApplicationRecord
  belongs_to :user

  mount_uploader :image, ChildPresentImageUploader
  validates :image, file_size: { less_than: 2.megabytes }

  validates :name, presence: true
end
