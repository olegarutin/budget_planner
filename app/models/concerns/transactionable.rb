module Transactionable
  extend ActiveSupport::Concern

  def user_categories(user_wallet, transaction_type, start_date, end_date)
    where(wallet_id: user_wallet)
      .for_date_range(start_date, end_date)
      .public_send(transaction_type)
      .pluck(:category_id).uniq
  end

  def amount_for_categories(user_wallet, transaction_type, start_date, end_date)
    where(wallet_id: user_wallet)
      .for_date_range(start_date, end_date)
      .public_send(transaction_type)
      .includes(:category).group(:category_id)
      .sum(:amount).values.map { |value| value / 100.to_f }
  end

  def category_title(user_wallet, transaction_type, start_date, end_date)
    where(wallet_id: user_wallet)
      .for_date_range(start_date, end_date)
      .public_send(transaction_type)
      .includes(:category).pluck(:title).uniq
  end

  def all_categories_titles
    includes(:category).pluck(:title).uniq
  end
end
