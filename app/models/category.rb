class Category < ApplicationRecord
  validates :title, presence: true

  belongs_to :user, optional: true
  has_many :transactions, dependent: :destroy

  enum transaction_type: %i[income expense]
end
