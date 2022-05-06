class Transaction < ApplicationRecord
  INCOME_TYPE = :income
  EXPENSE_TYPE = :expense

  TYPES = [INCOME_TYPE, EXPENSE_TYPE].freeze

  belongs_to :wallet
  belongs_to :category
  belongs_to :user

  enum transaction_type: TYPES
end
