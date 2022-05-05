class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :wallets, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :transactions, dependent: :destroy

  def user_categories
    Transaction.expense.select(:category_id).group(:category_id).count.keys
  end

  def user_catefories_count
    Transaction.expense.select(:category_id).group(:category_id).count.values
  end

  def amount_spent_on_transaction
    Transaction.expense.map{ |x| x.amount }
  end

  def amount_for_categories
    user_categories.zip(amount_spent_on_transaction).map{ |i, j| i * j }
  end
end
