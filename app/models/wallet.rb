class Wallet < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy

  validates :name, uniqueness: true, length: { maximum: 64 }, on: :create
  validates :name, :currency, presence: true
  validates :quantity, numericality: { greater_than: 0 }, on: :create

  scope :date_range, -> (start_date, end_date) { where(created_at: start_date.beginning_of_day..end_date.end_of_day) }
end
