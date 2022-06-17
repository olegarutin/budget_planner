class Transaction < ApplicationRecord
  extend Transactionable

  INCOME_TYPE = :income
  EXPENSE_TYPE = :expense

  TYPES = [INCOME_TYPE, EXPENSE_TYPE].freeze

  belongs_to :wallet
  belongs_to :category
  belongs_to :user

  scope :for_date_range, ->(start_date, end_date) { where(created_at: start_date..end_date) }

  enum transaction_type: TYPES

  validates :amount, numericality: { greater_than: 0, less_than: 1_000_000_00 }
  validates :note, length: { maximum: 140 }

  after_update_commit { broadcast_replace_to 'transactions' }
  after_destroy_commit { broadcast_remove_to 'transactions' }

  def convert_to_currency_format
    amount / 100.to_f
  end
end
