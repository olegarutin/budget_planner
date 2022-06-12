class Category < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :user_id }, length: { maximum: 20 }

  belongs_to :user, optional: true
  has_many :transactions, dependent: :destroy

  enum transaction_type: %i[income expense]
end
