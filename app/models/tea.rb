class Tea < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, presence: true

  has_many :subscriptions
  has_many :customers, through: :subscriptions
end