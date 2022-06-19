class Wallet < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy

  validates :name, uniqueness: { scope: :user_id }, length: { maximum: 20 }, on: :create
  validates :name, :currency, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0, less_than: 1_000_000_00 }, on: :create

  scope :date_range, ->(start_date, end_date) { where(created_at: start_date.beginning_of_day..end_date.end_of_day) }

  after_create_commit { broadcast_append_to 'wallets' }
  after_update_commit { broadcast_replace_to 'wallets' }
  after_destroy_commit { broadcast_remove_to 'wallets' }

  def convert_to_currency_format
    quantity / 100.to_f
  end
end
