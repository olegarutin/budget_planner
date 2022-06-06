module Transactionable
  extend ActiveSupport::Concern

  def user_categories(transaction_type)
    transactions.public_send(transaction_type)
      .pluck(:category_id).uniq
  end

  def amount_for_categories(transaction_type)
    transactions.public_send(transaction_type)
      .includes(:category).group(:category_id)
      .sum(:amount).values
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

  def transactoinable_params
    #params[:transaction_type], params[:start_date], params[:end_date]
  end
end