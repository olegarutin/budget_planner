class ReportsController < ApplicationController
  def index
    # @expense_by_days = Wallet.date_range(created_at.day, Date.today).quantity
    @transaction_type = params[:transaction_type] || 'expense'
    @start_date = params[:start_date] || 7.days.ago.to_date.to_s
    @end_date = params[:end_date] || Date.today.to_date.to_s
  end
end
