class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :wallets, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :transactions, dependent: :destroy

  has_many :expense_transaction_categories,
    -> { where("transactions.transaction_type = 1") },
    through: :transactions, source: :category

  has_many :income_transaction_categories,
    -> { where("transactions.transaction_type = 0") },
    through: :transactions, source: :category

  def user_categories(type: :expense)
    public_send("#{type}_transaction_categories").ids
  end

  def amount_for_categories(type: :expense)
    transactions.public_send(type).group(:category_id).sum(:amount).values
  end

  def category_title(type: :expense)
    public_send("#{type}_transaction_categories").pluck(:title)
  end
end
