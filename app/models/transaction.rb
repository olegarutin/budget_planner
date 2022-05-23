class Transaction < ApplicationRecord
  INCOME_TYPE = :income
  EXPENSE_TYPE = :expense

  TYPES = [INCOME_TYPE, EXPENSE_TYPE].freeze

  belongs_to :wallet
  belongs_to :category
  belongs_to :user

  enum transaction_type: TYPES

  validates :amount, numericality: { greater_than: 0 }
  validates :note, length: { maximum: 140 }

  after_update_commit { broadcast_replace_to 'transactions' }
  after_destroy_commit { broadcast_remove_to 'transactions' }

  scope :for_date_range, -> (start_date, end_date) { where(created_at: start_date.beginning_of_day..end_date.end_of_day)}
end
