class Transaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :category

  enum transaction_type: ['expense', 'income']
end
