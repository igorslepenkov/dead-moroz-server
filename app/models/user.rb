class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :invitable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  enum :role, Constants::USER_ROLES
  validates :role, presence: true
  validates :name, presence: true, length: { in: 3..50 }
  validates :email, presence: true, uniqueness: true

  has_one :child_profile, dependent: :destroy, validate: true

  has_many :child_presents, dependent: :destroy, validate: true

  scope :children, -> { where(role: Constants::USER_ROLES[:child]).where.associated(:child_profile) }
end
