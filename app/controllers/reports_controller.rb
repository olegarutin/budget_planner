class ReportsController < ApplicationController
  def index
    # @expense_by_days = Wallet.date_range(created_at.day, Date.today).quantity
    #@users_transactions_by_days = current_user.transactions.for_date_range(created_at.day..Date.today)
    @transaction_type = params[:transaction_type]
    @start_date = params[:start_date]
    @end_date = params[:end_date]
  end
end
