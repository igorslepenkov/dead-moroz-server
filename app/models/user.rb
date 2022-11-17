class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :invitable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  enum :role, Constants::USER_ROLES
  validates :role, presence: true
  validates :name, presence: true, length: { in: 3..50 }
  validates :email, presence: true, uniqueness: true
end
