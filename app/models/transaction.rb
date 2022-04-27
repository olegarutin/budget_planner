class Transaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :category

  enum transaction_type: %i[income expense]
end
