class ReportsController < ApplicationController
  def index
    @user_wallet = params[:user_wallet] || current_user.wallets.last
    @transaction_type = params[:transaction_type] || 'expense'
    @start_date = params[:start_date] || (Time.current.to_date - 7.days)
    @end_date = params[:end_date] || Time.current.to_date
    @previous_wallet = params[:user_wallet]
  end
end
