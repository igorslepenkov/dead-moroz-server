class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :invitable
  enum :role, Constants::USER_ROLES
  validates :role, presence: true
end
