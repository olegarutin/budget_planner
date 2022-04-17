class Transaction < ApplicationRecord
  belongs_to :wallet

  enum transaction_type: ['expense', 'income']
end
