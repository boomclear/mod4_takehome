class Customer < ApplicationRecord
  validates :email, uniqueness: true
  validates :first_name, :email, :last_name, :address, presence: true

  has_many :subscriptions
  has_many :teas, through: :subscriptions
end