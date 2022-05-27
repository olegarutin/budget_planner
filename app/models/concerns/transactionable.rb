module Transactionable
  extend ActiveSupport::Concern

  included do
    scope :for_date_range, -> (start_date, end_date) { transactions.where(created_at: start_date.beginning_of_day..end_date.end_of_day)}
  end
	


  def user_categories(type: :expense)
    transactions.public_send(type).pluck(:category_id).uniq
  end

  def amount_for_categories(type: :expense)
    transactions.public_send(type).includes(:category).group(:category_id).sum(:amount).values
  end

  def amount_for_income(type: :income)
    transactions.income.includes(:category).group(:category_id).sum(:amount).values
  end

  def category_title(type: :expense)
    transactions.public_send(type).includes(:category).pluck(:title).uniq
  end

  def all_categories_titles
    transactions.includes(:category).pluck(:title).uniq
  end

  def income_categories_title
    transactions.income.includes(:category).pluck(:title).uniq
  end

  def expense_categories_title
    transactions.expense.includes(:category).pluck(:title).uniq
  end
end