class Subscription < ApplicationRecord
  validates :subscription_id, uniqueness: true
  validates :subscription_id, :monthly_fee, :status, :frequency, presence: true

  belongs_to :customer
  belongs_to :tea

  enum status: {cancelled: 0, active: 1, pending: 2}
  enum frequency: {monthly: 0, bi_weekly: 1, weekly: 2}
end
