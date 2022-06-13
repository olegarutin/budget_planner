class Wallet < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy

  validates :name, uniqueness: { scope: :user_id }, length: { maximum: 20 }, on: :create
  validates :name, :currency, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }, on: :create

  scope :date_range, -> (start_date, end_date) { where(created_at: start_date.beginning_of_day..end_date.end_of_day) }
end
