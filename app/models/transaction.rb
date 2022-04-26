class Transaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :category

  enum transaction_type: { income: 0, expense: 1 }
end
