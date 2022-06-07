module Transactionable
  extend ActiveSupport::Concern

  def user_categories(transaction_type, start_date, end_date)
    transactions.for_date_range(start_date, end_date)
      .public_send(transaction_type)
      .pluck(:category_id).uniq
  end

  def amount_for_categories(transaction_type, start_date, end_date)
    transactions.for_date_range(start_date, end_date)
      .public_send(transaction_type)
      .includes(:category).group(:category_id)
      .sum(:amount).values
  end

  def category_title(transaction_type, start_date, end_date)
    transactions.for_date_range(start_date, end_date)
      .public_send(transaction_type)
      .includes(:category).pluck(:title).uniq
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