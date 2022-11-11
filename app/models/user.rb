class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :invitable
  enum :role, Constants::ROLE
  validates :role, presence: true
end
